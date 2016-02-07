require_relative 'calendar_booklet'
require_relative 'calendar_summary'
require_relative 'calendar_print'
require_relative 'authorizable'
require_relative 'functions'
require 'awesome_print'

include Authorizable
include Functions

APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

read_calendars.each do |name, calendar_id|

  response = service.list_events(calendar_id,
                                 single_events: true,
                                 order_by: 'startTime')

  calendar_prints = response.items.map do |item|
    CalendarPrint.from_hash(
              title: item.summary,
               from: parse_date(item.start),
                 to: parse_date(item.end),
        description: item.description || '')
  end


  begin
    CalendarSummary.new(calendar_prints).render_file("pdfs/#{name}_summary.pdf")
    CalendarBooklet.new(calendar_prints).render_file("pdfs/#{name}_booklet.pdf")
  rescue Exception => e
    puts e
  end

end
