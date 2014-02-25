class UploadController < ApplicationController
  before_filter :authenticate_account!
  
  def new
  end
  
  def create
    @output = nil
    begin
      name = Digest::MD5.new.update(rand.to_s + Time.now.to_s).to_s + File.extname(params[:image].original_filename).downcase
      dir = Rails.root + "../../shared/public/system/"
      Dir.mkdir(dir) unless File.exists?(dir)
      path = dir + name
      raise if(File.exists?(path))
      File.open(path, 'wb') {|f| f.write(params[:image].read)}
      uri = "/static/#{name}"
      @output = "<img src='#{uri}' />"  
    rescue => e
      @output = e.message
    end
  end
  
end