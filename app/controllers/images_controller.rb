class ImagesController < ApplicationController
    before_action :require_login
    
    def upload
        @image = Image.new
        @image.file = params[:upload_file]
        @image.user = @current_user
        success = false
        msg = 'upload success'
        if @image.save
            success=true
            render json: { :success=> success, :msg=>msg, :file_path=> @image.file.url }
        else
            render json: { :success=> false }
        end
    end

end
