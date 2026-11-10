#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "fileutils"
require "time"

ROOT_DIR = File.expand_path("../..", __dir__)
REPORT_DIR = File.join(ROOT_DIR, "tmp", "newman-reports")
OUT_MD = File.join(ROOT_DIR, "tmp", "newman-report.md")

report_files = Dir.glob(File.join(REPORT_DIR, "*.json")).sort
if report_files.empty?
  warn "No Newman JSON reports found in #{REPORT_DIR}"
  exit 1
end

def extract_url(request)
  raw = request.dig("url", "raw")
  return raw unless raw.to_s.empty?

  url = request["url"] || {}
  host = Array(url["host"]).join(".")
  path = Array(url["path"]).join("/")
  query = Array(url["query"]).map { |q| "#{q['key']}=#{q['value']}" }.join("&")

  base = ""
  base += "#{url['protocol']}://" if url["protocol"]
  base += host
  base += "/#{path}" unless path.empty?
  base += "?#{query}" unless query.empty?
  base
end

rows = []
status_count = Hash.new(0)
error_count = 0
request_error_count = Hash.new(0)

report_files.each do |file|
  payload = JSON.parse(File.read(file))
  collection_name = payload.dig("collection", "name") || File.basename(file, ".json")
  executions = payload.dig("run", "executions") || []

  executions.each do |execution|
    request = execution["request"] || {}
    response = execution["response"] || {}

    method = request["method"].to_s
    url = extract_url(request)
    item_name = execution.dig("item", "name").to_s
    code = response["code"]
    status = response["status"].to_s
    response_time = response["responseTime"]
    request_error = execution["requestError"] || {}
    request_error_code = request_error["code"].to_s
    request_error_host = request_error["hostname"].to_s
    request_error_message = request_error["message"].to_s

    if !request_error_code.empty?
      request_error_count[request_error_code] += 1
    end

    code_label = code ? code.to_s : "N/A"
    status_count[code_label] += 1

    if code.nil? || code.to_i >= 400
      error_count += 1
    end

    rows << {
      collection: collection_name,
      item: item_name,
      method: method,
      url: url,
      code: code_label,
      status: status,
      response_time: response_time,
      request_error_code: request_error_code,
      request_error_host: request_error_host,
      request_error_message: request_error_message
    }
  end
end

total_requests = rows.length
ok_requests = total_requests - error_count

markdown = +""
markdown << "# Newman API Test Report\n\n"
markdown << "Generated at: #{Time.now.utc.iso8601}\n\n"
markdown << "## Summary\n\n"
markdown << "- Total requests: #{total_requests}\n"
markdown << "- Successful (<400): #{ok_requests}\n"
markdown << "- Non-success (>=400 or no response): #{error_count}\n"
markdown << "- Status breakdown: #{status_count.sort_by { |k, _| k.to_i }.map { |k, v| "#{k}=#{v}" }.join(', ')}\n\n"

if request_error_count.any?
  markdown << "## Network/Transport Errors\n\n"
  markdown << "- Request error breakdown: #{request_error_count.sort_by { |k, _| k }.map { |k, v| "#{k}=#{v}" }.join(', ')}\n\n"
end

markdown << "## Request Results\n\n"
markdown << "| Collection | Request | Method | Status Code | Status | Response Time (ms) | Request Error | URL |\n"
markdown << "| --- | --- | --- | --- | --- | ---: | --- | --- |\n"
rows.each do |row|
  request_error_label = row[:request_error_code]
  if request_error_label.empty?
    request_error_label = "-"
  elsif !row[:request_error_host].empty?
    request_error_label = "#{request_error_label} (#{row[:request_error_host]})"
  elsif !row[:request_error_message].empty?
    request_error_label = "#{request_error_label}: #{row[:request_error_message]}"
  end

  markdown << "| #{row[:collection]} | #{row[:item]} | #{row[:method]} | #{row[:code]} | #{row[:status]} | #{row[:response_time] || 'N/A'} | #{request_error_label} | #{row[:url]} |\n"
end

FileUtils.mkdir_p(File.dirname(OUT_MD))
File.write(OUT_MD, markdown)

puts "Wrote #{OUT_MD}"
puts "Requests: #{total_requests}, non-success: #{error_count}"
