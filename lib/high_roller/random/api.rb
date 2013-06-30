require 'net/http'

class HighRoller::Random::Api < HighRoller::Random::Base
  QuotaURI = URI('http://www.random.org/quota/?format=plain')
  RandomURI = URI('http://www.random.org/integers/')
  RandomQueryDefaults = {
    min: 1,
    col: 1,
    base: 10,
    format: 'plain',
    rnd: 'new'
  }
  UserAgent = "HighRoller v#{HighRoller::VERSION} (RUBY/#{RUBY_VERSION}) <joshua.s.lindsey@gmail.com>"

  LowQuotaWarningThreshold = 500
  LowQuotaAlertThreshold = 100

  attr_reader :quota

  def initialize opts
    super opts
    @http = Net::HTTP.new RandomURI.host, RandomURI.port
    @request_count = (1..Float::INFINITY).each
    refresh_quota!
  end

  def refresh_quota!
    @quota_query ||= Net::HTTP::Get.new QuotaURI.request_uri
    @quota_query['User-Agent'] ||= UserAgent

    resp = @http.request @quota_query
    if resp.code != '200'
      raise HighRoller::Exceptions::BadServerResponse.new("Bad response from server: #{resp.code} - #{resp.body.strip}")
    end

    @quota = resp.body.strip.to_i
    check_quota_thresholds
  end

  def fetch rads = nil
    if @quota <= 0
      raise HighRoller::Exceptions::QuotaExceeded.new
    end

    radixes = rads || @radixes
    out = {}

    radixes.each do |rad|
      query = RandomQueryDefaults.dup
      uri = RandomURI.dup
      query[:max] = rad
      query[:num] = @preload
      uri.query = URI.encode_www_form query

      req = Net::HTTP::Get.new uri.request_uri
      req['User-Agent'] = UserAgent

      resp = @http.request req
      if resp.code != '200'
        raise HighRoller::Exceptions::BadServerResponse.new("Bad response from server: #{resp.code} - #{resp.body.strip}")
      end

      if @request_count.next % 5 == 0
        refresh_quota!
      else
        quota_delta = radixes.reduce(0) { |sum, rad| sum += (rad.to_s(2).length * @preload) }
        @quota -= quota_delta
        check_quota_thresholds
      end

      out[rad] = resp.body.split("\n").map { |n| n.strip.to_i }
    end

    out
  end

  def check_quota_thresholds
    str = ''

    if @quota <= 0
      raise HighRoller::Exceptions::QuotaExceeded.new
    elsif @quota <= LowQuotaAlertThreshold
      str = "ALERT: Quota nearing empty! (#{@quota} bits remaining)"
    elsif @quota <= LowQuotaWarningThreshold
      str = "WARNING: Quota low! (#{@quota} bits remaining)"
    end

    unless str.empty?
      puts str
      puts "One 1d20 roll is 5 bits."
    end
  end
end
