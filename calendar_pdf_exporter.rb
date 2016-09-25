require_relative 'lib/print/calendar_booklet'
require_relative 'lib/print/calendar_summary'
require_relative 'lib/calendar_gateway/calendar_print'
require_relative 'lib/calendar_gateway/calendar_extractor'

def export_pdf(name, calendar_prints)
  begin
    CalendarSummary.new(calendar_prints).render_file("pdfs/#{name}_summary.pdf")
    CalendarBooklet.new(calendar_prints).render_file("pdfs/#{name}_booklet.pdf")
  rescue Exception => e
    puts e
  end
end

extractor = CalendarExtractor.new
extractor.extract.each do |name, calendar_print|
  filter = calendar_print.select {|print| print.title.downcase.include?('hatta')}
  export_pdf(name, filter)
end
