# frozen_string_literal: true

module NewsmastMastodon
  # Fetches link preview metadata for a given URL using Mastodon's native
  # HTTP stack (Request) together with FetchOEmbedService and
  # LinkDetailsExtractor. This replaces the previous link_thumbnailer based
  # implementation so the host app no longer needs the faraday-typhoeus gem.
  #
  # The returned hash keeps the backward-compatible shape that clients of the
  # /api/v1/utilities/link_preview endpoint already expect:
  #
  #   {
  #     title:       String,
  #     description: String,
  #     images:      [{ src: String, width: Integer, height: Integer }],
  #     url:         String
  #   }
  class FetchLinkMetadataService < BaseService
    # Raised when the URL is syntactically invalid or points to a disallowed host.
    class InvalidURLError < StandardError; end

    # Raised when the remote resource could not be fetched or yielded no metadata.
    class FetchError < StandardError; end

    def call(url)
      @original_url = parse_url(url)
      @url          = @original_url.to_s

      fetch_html

      raise FetchError, "Unable to fetch the provided URL" if @html.nil?

      attributes = extract_via_oembed || extract_via_opengraph

      raise FetchError, "No preview metadata found for the provided URL" if attributes.nil?

      attributes
    rescue *Mastodon::HTTP_CONNECTION_ERRORS, Mastodon::LengthValidationError, Encoding::UndefinedConversionError => e
      raise FetchError, e.message
    rescue Addressable::URI::InvalidURIError, Mastodon::HostValidationError => e
      raise InvalidURLError, e.message
    end

    private

    def parse_url(url)
      raise InvalidURLError, "URL must be present" if url.blank?

      uri = Addressable::URI.parse(url).normalize

      raise InvalidURLError, "URL is not valid" if uri.host.blank? || !%w[http https].include?(uri.scheme)

      uri
    end

    # Mirrors FetchLinkCardService#html: only accept successful HTML responses,
    # follow redirects and remember the final URL + charset of the document.
    def fetch_html
      headers = {
        "Accept" => "text/html",
        "Accept-Language" => "#{I18n.default_locale}, *;q=0.5",
        "User-Agent" => "#{Mastodon::Version.user_agent} Bot"
      }

      @html = Request.new(:get, @url).add_headers(headers).perform do |res|
        next unless res.code == 200 && res.mime_type == "text/html"

        @url          = res.request.uri.to_s
        @html_charset = res.charset

        res.truncated_body
      end
    end

    def extract_via_oembed
      embed = FetchOEmbedService.new.call(@url, html: @html)

      return if embed.nil?

      image_url = embed[:thumbnail_url].presence || (embed[:type].to_s == "photo" ? embed[:url] : nil)

      images = if image_url.present?
                 [ { src: absolute_url(image_url), width: embed[:width].to_i, height: embed[:height].to_i } ]
      else
                 []
      end

      {
        title: embed[:title].to_s,
        description: "",
        images: images,
        url: @url
      }
    end

    def extract_via_opengraph
      attributes = LinkDetailsExtractor.new(@url, @html, @html_charset).to_preview_card_attributes

      return if attributes[:title].blank? && attributes[:image_remote_url].blank?

      images = if attributes[:image_remote_url].present?
                 [ { src: attributes[:image_remote_url], width: attributes[:width].to_i, height: attributes[:height].to_i } ]
      else
                 []
      end

      {
        title: attributes[:title].to_s,
        description: attributes[:description].to_s,
        images: images,
        url: @url
      }
    end

    def absolute_url(url)
      (Addressable::URI.parse(@url) + url).to_s
    rescue Addressable::URI::InvalidURIError
      url
    end
  end
end
