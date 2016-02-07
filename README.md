# Print Calendar

## Summary

This pet project is due to my need to export google calendar events and print 
them. I use google calendar ruby api in order to export the events and prawn to 
print them in a suitable format.

## Notes

I have used the quickstart.rb example in this 
[link](https://developers.google.com/google-apps/calendar/quickstart/ruby) as a 
starting point.

The file that I need to run is the **calendar_pdf_exporter.rb**. Before runnning
the file you need to place client_secret.json under the project root folder.
This first time that you run the file it creates the file 
~/.credentials/calendar_ruby_quickstart.yml which contains data for 
authenticating with Google Calendar. The next time it will read this file and use
its data for the authentication process.

I also use a yml file that contains the name of the calendar as a key and the 
google calendar id as a value. The file is 
~/.credentials/calendar_ruby_configuration.yml and it has the following format:
I 
```
---
:calendars:
  :primary: primary
```

You can either create that file manually or use the save_calendars method in 
Functions module.

The script will iterate over those calendars, it will extract the events and it
will product 2 pdf files for each calendar. This first is a summary that it will
present a summary table of the events and the second will be a report that will
use one page for each event. The pdf files will be placed under the pdfs folder.
