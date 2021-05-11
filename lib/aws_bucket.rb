module Awsbucket
  require 'aws-sdk-s3'
  
  def s3Upload image,folder,fileName
    directory = awsS3Connection.directories.get(ENV["S3NAME"])
    result = nil
    begin
      @filePath = "#{ENV['NAMESPACE']}/#{folder}/#{fileName}"
      begin
        s3_file = directory.files.new({
          :key => @filePath,
          :body => image,
          :public => true
        })
        result = s3_file.public_url if s3_file.save
      rescue Exception => e
        p "xxxxx #{e}"
      end
    rescue Exception => e
      p "xxxx #{e}"
    end
    result
  end

  def destroy_image_on_s3_bucket folder,fileUrl
    directory = awsS3Connection.directories.get(ENV["S3NAME"])
    begin
      fileName = fileUrl.to_s.split('/').last
      if fileName.present?
        @filePath = "#{ENV['NAMESPACE']}/#{folder}/#{fileName}"
        file = directory.files.get(@filePath)
        file.destroy if file.present?
      end
    rescue Exception=>e
      p "xxxxxxxxxxx #{e}"
    end
  end

  def awsS3Connection
    connection = Fog::AWS::Storage.new({
      :aws_access_key_id => ENV["AWSAKEY"],
      :aws_secret_access_key => ENV["AWSSKEY"],
      :region => ENV["S3REGION"],
      :path_style=>true
    })
  end

  
end