require_relative 'calendar_extractor'

template = %Q(
### <%=title%>
<%=from.strftime('%d-%m-%Y %H:%M')%> to <%=to.strftime('%d-%m-%Y %H:%M')%>

<%=description%>

-----

)

extractor = CalendarExtractor.new
extractor.extract.each do |name, calendar_print|
  filter = calendar_print.select {|print| print.title.downcase.include?('hatta')}

  renderer = ERB.new(template)

  filter.each do |pc|
    title = pc.title
    from = pc.from
    to = pc.to
    description = pc.description
    output = renderer.result(binding)

    puts output
  end
end
