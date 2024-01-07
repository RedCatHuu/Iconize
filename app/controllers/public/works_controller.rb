class Public::WorksController < ApplicationController
  
  def new
  end
  
  def index
  end

  def show
  end
  
  def create
    work = Work.new(work_params)
    work.user_id = current_user.id
    
    # サムネイルを作成し保存
    if work.save
      work.images.each do |img|
        downloaded_image = img.download
        image = MiniMagick::Image.read(downloaded_image)
        image.trim
        tmp_file = Tempfile.new(['trimmed_', ".#{image.type.downcase}"], 'tmp')
        image.write(tmp_file.path)
        tmp_file.rewind
        trimmed_blob = ActiveStorage::Blob.create_and_upload!(
          io: tmp_file,
          filename: "trimmed_#{img.filename}",
          content_type: image.mime_type
        )
        work.thumbnails.attach(trimmed_blob)
        tmp_file.close
        tmp_file.unlink
      end
      redirect_to works_path
    else
      @works = PostImage.all
      flash.now[:notice] = "失敗しました。"
      render :index
    end
  end
  
  def edit
  end 
  

  def update
  end

  def destroy
  end

  def bookmarks
  end
  
  private
  
  def work_params
    params.require(:work).permit(:genre, images: [])
  end
  
end
