class Public::WorksController < ApplicationController
  
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:index, :show ]
  
  def new
    # サークル詳細から投稿画面に遷移してきた場合
    @work = Work.new
    club_id = params[:club_id]
    if club_id != nil
      @club = Club.find(params[:club_id])
    end
  end
  
  def index
    @works = Work.all
  end

  def show
    @work = Work.find(params[:id])
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user, work_id: @work.id)
      current_user.read_counts.create(work_id: @work.id)
    end 
  end
  
  def create
    @work = current_user.works.build(work_params)
    @work.user_id = nil
    club_id = params[:work][:club_id]
    if club_id == nil
      @work.user_id = current_user.id
    end
    
    unless @work.items[0].present?
      flash.now[:alert] = "アイテム欄を記入してください"
      return render :new
    end
    
    # サムネイルを作成し保存
    if @work.save
      @work.items.each do |item|
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
      redirect_to work_path(@work)
    else
      # サークル詳細から来たならサークル情報を送る
      if club_id != nil
        @club = Club.find(club_id)
      end
      flash.now[:alert] = "失敗しました。"
      render :new
    end
  end
  
  def edit
    @work = Work.find(params[:id])
    @nth = 9 - @work.items_qty
  end 
  

  def update
    @work = Work.find(params[:id])
    
    unless @work.items[0].present?
      flash.now[:alert] = "アイテム欄を記入してください"
      return render :edit
    end
    
    if @work.update(work_params)
      # サムネイルを作成
      @work.items.each do |item|
        # すでにあるサムネイルはすべて削除
        item.thumbnails.destroy_all
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
      redirect_to work_path(@work), notice: "編集が完了しました。"
    else
      render :edit
    end
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to works_path
  end

  def download
    require "mini_magick"
    work = Work.find(params[:work][:id])
    items_size = work.items_qty
    image_numbers = []
    for nth_image in 0..items_size
      image_numbers << [params[:work]["item_number_#{nth_image}"]]
    end
    base_item_number = image_numbers[0][0].to_i
    base_image = work.items[0].images[base_item_number]
    base_image = base_image.download
    base_image = MiniMagick::Image.read(base_image)
    
    if not items_size == 0
      for nth in 1..items_size
        nth_image = image_numbers[nth][0].to_i  #[nth]としてもまだ配列なので[0]としてさらに配列から取得する
        input = work.items[nth].images[nth_image]
        base_image = base_image.composite(MiniMagick::Image.open(input)) do |config|
          config.compose "Over"
          config.gravity "NorthWest"
        end 
      end
    end 
    result = base_image
    send_data result.to_blob, type: "image/png", disposition: "attachment; filename = Iconize.png"
  end
  
  private
  
  def work_params
    params.require(:work).permit(:title,
                                 :caption, 
                                 :thumbnail,
                                 :club_id,
                                 items_attributes: [
                                   :id,
                                   :genre,
                                   images: []
                                   ]
                                 )
  end
  
  def ensure_correct_user
    @work = Work.find(params[:id])
    unless @work.user == current_user
      redirect_to works_path
    end
  end
  
end
