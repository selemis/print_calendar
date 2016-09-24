require_relative 'calendar_authorizable'
require_relative 'calendar_print'
require_relative 'functions'
require 'awesome_print'
require 'active_support/core_ext/hash/keys'

##
# Extract information from google calendar

class CalendarExtractor
  include CalendarAuthorizable
  include Functions

  APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'

  def initialize
    # Initialize the API
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  ##
  # It returns a hash with key the name of the calendar
  # and value corresponding the CalendarPrint Object.
  def extract
    named_calendar_prints = Hash.new
    named_responses = to_named_responses(@service)
    named_responses.each do |name, response|
      named_calendar_prints[name] = to_calendar_prints(response)
    end
    named_calendar_prints
  end

  private

  def to_named_responses(service)
    named_responses = Hash.new
    read_calendars.each do |name, calendar|
      id = calendar.delete(:id)
      named_responses[name] = service.list_events(id, calendar.symbolize_keys!)
    end
    named_responses
  end

  def to_calendar_prints(response)
    response.items.map do |item|
      CalendarPrint.from_hash(title: item.summary,
                               from: parse_date(item.start),
                                 to: parse_date(item.end),
                        description: item.description || '')
    end

  end

end