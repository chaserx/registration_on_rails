class DashboardsController < ApplicationController
  
  before_filter :login_required
  
  # GET /registrations
  # GET /registrations.xml
  def index
    @registrations = Registration.find(:all, :order => "created_at ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registrations }
      format.csv {
            registrations = Registration.find(:all, :order => "lastname ASC")
            csv = FasterCSV.generate do |csv|
              csv << ["Name", "Dept.", "Org.", "Address1", "Address2", "City", "State", "Zip", "Phone", "email", "Lunch", "EveningSession", "Partysize", "Fees", "BusinessOfficer", "BizOfficerEmail", "BizOfficerPhone", "Date Registered"]
              registrations.each do |registration|
                csv << [[registration.title, registration.firstname, registration.lastname].join(" ").strip, registration.dept, registration.organization, registration.address1, registration.address2, registration.city, registration.state, registration.zip, registration.phone, registration.email, registration.lunch, registration.eveningsession, registration.partysize, registration.fees, registration.bizperson, registration.bizpersonemail, registration.bizpersonphone, registration.created_at ]
              end
            end
            t = Time.now
            send_data(csv, :filename => "Registrations#{t.strftime("%m_%d_%Y")}.csv", 
                      :type => 'text/csv', :disposition => 'attachment')
          }
      #format.zip code mostly from Practical Rails Plugins by Nick Plante, David Berube    
      format.zip {
            registrations_with_attachments = Registration.find_by_sql('SELECT * FROM registrations WHERE abstract_file_name NOT LIKE ""')
            headers['Cache-Control'] = 'no-cache'
            tmp_filename = "#{RAILS_ROOT}/tmp/tmp_zip_" <<
                            Time.now.to_f.to_s <<
                            ".zip"
                            
            # rubyzip gem version 0.9.1
            # rdoc http://rubyzip.sourceforge.net/                
            Zip::ZipFile.open(tmp_filename, Zip::ZipFile::CREATE) do |zip|
              #get all of the attachments
              
              #works. Thanks to Henrik Nyh
              registrations_with_attachments.each { |e| zip.add("abstracts/#{e.abstract.original_filename}", e.abstract.path)  }
              
              #registrations_with_attachments.each { |e| zip.read(e.abstract.url) }
              #=> Error:  Errno::ENOENT in RegistrationsController#index. No such file or directory - /abstracts/cN2_iGSSGr3yw0abTJTXpe/original/test.docx?1226721077
              
              #zip.get_input_stream(registrations_with_attachments.each { |e| send_data(e.abstract.url)  })
              #=> Result: Apparently Corrupt .zip file with the wrong filename (registrations.zip)
                            
              #registrations_with_attachments.each { |e| zip.add("abstracts/#{e.abstract.original_filename}", send_data(e.abstract.url))  }
              #=> Result: Apparently Corrupt .zip file with the wrong file name. Filename should be something like tmp_zip_1226936644.54502.zip; Sent as registrations.zip; Mac OS X Archive Utililty compresses into registrations.zip.cpgz
              
              #registrations_with_attachments.each { |e| zip.add("abstracts/#{e.abstract.original_filename}", send_file(e.abstract.url))  }                      
              #=> Error: ActionController::MissingFile in RegistrationsController#index. Cannot read file /abstracts/cN2_iGSSGr3yw0abTJTXpe/original/test.docx?1226721077
              
              #registrations_with_attachments.each { |e| zip.add("abstracts/#{e.abstract.original_filename}", e.abstract.url)  }
              #=> Error:  Errno::ENOENT in RegistrationsController#index. No such file or directory - /abstracts/cN2_iGSSGr3yw0abTJTXpe/original/test.docx?1226721077
            end
            # send data through the browser
            # sending with just the contents of the empty tmp_file also results in an apparently corrupt zip file, but sent with the filename as the entire pwd-tmp_zip_1226936896.53403.zip
            send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => tmp_filename.to_s)
            File.delete tmp_filename
      }
    
    end
  end
    
  def show
    @registrations = Registration.find(:all, :order => "created_at ASC")
    
    
    respond_to do |format|
      format.html
    end
  end

end
