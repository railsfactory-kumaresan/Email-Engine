module CsvUploadStatus
  extend ActiveSupport::Concern
  included do

    def self.csv_message_block(user, success_count, error_count, total_record, remaining_count,error_list_path)
      message = remaining_count != 0 ? "Business contacts have been uploaded successfully." : "You have reached the maximum upload limit."
      download_link = size > 2000 ? "Check here for invalid and upload records #{uploaded_public_url(error_list_path)}" : ''
      %Q{
        <p>Dear #{user.first_name},</p>
        <p> #{message}
        <p>Total contacts : #{total_record} </p>
        <p>No of contacts uploaded successfully : #{success_count}</p>
        <p>No of contacts not loaded : #{error_count < 0 ? 0 : error_count}</p>
        <p>Remaining no of contacts in allocated limit : #{remaining_count}</p>
        <p>#{download_link} </p>
        Regards,<br>
        Inquirly Admin<br>
      }
    end 
  
    def self.get_message(user)
      {
        "subject" => "Customer Information Upload Process Completed",
        "from_email" => "admin@inquirly.com",
        "to" => [{"email" => user.email}],
        "important" => true,
        "global_merge_vars" => [{ "name" => "IMAGE", "content" => "<img src='https://ci6.googleusercontent.com/proxy/IpWIMZpcje9FAYBX5PLyWtf096Jkre8VRXmU02JaeeCWNddK7KptgTHxpfgK_pDwU7si98W9M57cGfcgva1MlkGtrIe1oZmK0DLv7ohUp1UhOHc=s0-d-e1-ft#https://beta.inquirly.com/ng-app/Images/header-login-logo.png' mc:label='header_image' mc:edit='header_image' style='max-width:540px; text-align:centre;'>" }]
      }
    end

    def self.uploaded_public_url(error_list_path)
      key = File.basename(error_list_path)
      bucket_name = ENV['AWS_BUCKET']
      s3 = Aws::S3::Resource.new
      obj = s3.bucket(bucket_name).object(key)
      obj.upload_file(error_list_path, acl:'public-read')
      obj.public_url
    end

    def self.csv_error_message(user,csv_file_status)
      %Q{
        <p> Dear #{user.first_name},</p>
        <p> CSV file format is not valid. Please check the format and try again.</p>
        Regards,<br>
        Inquirly Admin
      }
    end

  end
end    