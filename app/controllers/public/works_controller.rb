class Public::WorksController < ApplicationController
  
  def new
  end
  
  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
    
  end
  
  def create
    work = current_user.works.build(work_params)
    
    # サムネイルを作成し保存
    if work.save
      work.items.each do |item|
        item.images.each do |img|
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
          item.thumbnails.attach(trimmed_blob)
          tmp_file.close
          tmp_file.unlink
        end
      end
      redirect_to works_path
    else
      @works = PostImage.all
      flash.now[:notice] = "失敗しました。"
      render :new
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
  
  def download
    require "mini_magick"
    which_images = params[:work][:images_d]
    # size = which_images.size
    
    post_image = PostImage.find(params[:id])
    base_image = post_image.base_image
    base_image = base_image.download
    base_image = MiniMagick::Image.read(base_image)
    
    which_images.each do |nth_image|
      input = post_image.images[nth_image.to_i]
      base_image = base_image.composite(MiniMagick::Image.open(input)) do |config|
        config.compose "Over"
        config.gravity "NorthWest"
      end 
    end
    result = base_image
    send_data result.to_blob, type: "image/png", disposition: "attachment; filename = fine.png"
  end
  
  private
  
  def work_params
    params.require(:work).permit(:name,
                                 :caption, 
                                 :base_image,
                                 items_attributes: [
                                   :genre,
                                   images: []
                                   ]
                                 )
  end
  
end
