require_relative 'calendar_booklet'
require_relative 'calendar_summary'
require_relative 'calendar_print'
require_relative 'authorizable'
require_relative 'functions'
require 'awesome_print'
require 'active_support/core_ext/hash/keys'

include Authorizable
include Functions

APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'

# Initialize the API
service = Google::Apis::CalendarV3::CalendarService.new
service.client_options.application_name = APPLICATION_NAME
service.authorization = authorize

cert_path = Gem.loaded_specs['google-api-client'].full_gem_path+'/lib/cacerts.pem'
ENV['SSL_CERT_FILE'] = cert_path

read_calendars.each do |name, calendar|
  id = calendar.delete(:id)
  response = service.list_events(id, calendar.symbolize_keys!)

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
