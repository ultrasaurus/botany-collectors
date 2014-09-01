require 'csv'

namespace :import do
  filename = 'data/collectors.csv'
  desc "import file: #{filename}"
  task collectors: :environment do
    path = "#{Rails.root}/#{filename}"
    puts "reading file: #{path}"

    mapping = {
      "CountOfParticIRN" => :count,
      "ParticIRN" => :irn,
      "NamFullName" => :full_name,
      "NamBriefName" => :brief_name,
      "BioBirthDate" => :birth_date,
      "BioDeathDate" => :death_date,
      "BioLocation_tab" => :bio_location,
      "AffStartDate0" => :start_date,
      "AffEndDate0" => :end_date
      }
    # note: eMu format is latin1
    
    File.foreach(path).with_index do |line, line_num|
     next if line_num == 0  # skip header
     begin
        data = []
        begin 
          data = line.chomp.split(",")
        rescue Exception => e 
          line = line.encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "?")
          data = line.chomp.split(",")          
          puts "\nException on line #{line_num}: #{e.message}\n#{line.inspect}"
        end

        attrs = {}
        mapping.values.each_with_index do |key, index|
          attrs[key] = data[index];
        end
        EmuPerson.create!(attrs)
        print '.' if line_num % 100 == 0
    rescue Exception => e 
      puts "\nException on line #{line_num}: #{e.message}"
     end
    end
    puts "\nimported #{EmuPerson.count}"
  end
end
