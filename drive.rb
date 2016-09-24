require_relative 'drive_authorizable'
require 'rake'
require 'fileutils'
require 'google/apis/calendar_v3'

class Drive
  include DriveAuthorizable

  FOLDER = '/home/selemis/Pictures/theoni_phone'

  def doit

    # Initialize the API
    service = Google::Apis::DriveV3::DriveService.new
    service.client_options.application_name = 'APPLICATION_NAME'
    service.authorization = authorize


     Rake::FileList.new("#{FOLDER}/*.jpg").pathmap('%f').each do |f|
       response = service.list_files(q: %(name contains "#{f}") )
       puts 'Files:'
       if response.files.empty?
         puts "No files found for #{f}"
         # FileUtils.mv "#{FOLDER}/#{f}", "#{FOLDER}/keep/#{f}", verbose: true
       end
       response.files.each do |file|
         puts "#{file.name} (#{file.id})"
       end

       if response.files.any?
         # FileUtils.mv "#{FOLDER}/#{f}", "#{FOLDER}/processed/#{f}", verbose: true
       end

     end

  end

end

if __FILE__ == $0
  Drive.new.doit
end
