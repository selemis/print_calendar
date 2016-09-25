# Print Calendar

## Summary

This pet project is due to my need to export google calendar events and print 
them. I use google calendar ruby api in order to export the events and prawn to 
print them in a suitable format.

## Notes

This application uses my [google_authorizer](https://github.com/selemis/google_authorizer).

There are two kinds of exporters at the moment. One of them export calendar event data to pdf files and the other
prints them on the command line.

For pdfs, the file that I need to run is the `calendar_pdf_exporter.rb`.
For the command line output, the file I need to run is the `cli_exporter.rb` 
 
Before runnning the file you need to place client_secret.json under the project root folder.

I also use a yml file that contains the name of the calendar as a key and the google calendar id as a value. The file is
`~/.credentials/calendar-ruby-configuration.yml` and it has the following format:
 
```
---
:calendars:                                                                      
   :primary:                                                                      
     :id: primary                                                                 
     :single_events: true                                                         
     :max_results: 2500                                                           
     :time_min: '2014-01-01T2:00:00-00:00'                                        
     :time_max: '2016-12-31T2:00:00-00:00'                                        
     :order_by: startTime                                                         
```

You can either create that file manually or use the save_calendars method in Functions module.

The script will iterate over those calendars, it will extract the events and it
will product 2 pdf files for each calendar. This first is a summary that it will
present a summary table of the events and the second will be a report that will
use one page for each event. The pdf files will be placed under the pdfs folder.
