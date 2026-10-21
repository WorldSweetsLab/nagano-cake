class Admin::GenresController < Admin::ApplicationController
  # 登録済みのジャンルと、新規登録用の入力欄を用意する
  def index
    @genres = Genre.order(:id)
    @genre = Genre.new
  end

  # 入力されたジャンル名を保存する
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      redirect_to admin_genres_path,
                  notice: "ジャンルを登録しました。"
    else
      @genres = Genre.order(:id)
      render :index, status: :unprocessable_entity
    end
  end

    # 編集するジャンルを取得する
  def edit
    @genre = Genre.find(params[:id])
  end

  # ジャンル名を更新する
  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to admin_genres_path,
                  notice: "ジャンルを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # フォームから受け取る項目をジャンル名に限定する
  def genre_params
    params.require(:genre).permit(:name)
  end
end