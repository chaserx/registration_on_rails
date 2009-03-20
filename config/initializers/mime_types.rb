# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

#commented out CSV mime type to eliminate an error on server start. still works apparently.
#Mime::Type.register "text/csv", :csv
Mime::Type.register "application/zip", :zip
Mime::Type.register "application/vnd.openxmlformats-officedocument.wordprocessingml.document", :docx
Mime::Type.register "application/msword", :doc
Mime::Type.register "text/plain", :txt
Mime::Type.register "application/pdf", :pdf
#CSRF Protection interm fix for Rails 2.1
Mime::Type.unverifiable_types.delete(:text)
