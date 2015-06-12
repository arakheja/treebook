class PicturesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_user
  before_filter :find_album
  before_filter :find_picture, only: [:edit, :update, :show, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @album.pictures.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  def slideshow
    @pictures = @album.pictures.order("created_at desc")

    respond_to do |format|
      format.html # slideshow.html.erb
      format.json { render json: @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    #@picture = @album.pictures.find(params[:id])
    add_breadcrumb @picture, album_pictures_path(@album, @picture)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.json
  def new
    @picture = @album.pictures.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @picture }
    end
  end

  # GET /pictures/1/edit
  def edit
    # @picture = Picture.find(params[:id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @album.pictures.new(params[:picture])
    # @picture.user = current_user

    respond_to do |format|
      if @picture.save
        current_user.create_activity(@picture, 'created')
        format.html { redirect_to album_pictures_path(@album), notice: 'Your picture was successfully uploaded.' }
        format.json { render json: @picture, status: :created, location: @picture }
      else
        format.html { render action: "new" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.json
  def update
    #@picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        # current_user.create_activity(@picture, 'updated')
        format.html { redirect_to album_pictures_path(@album), notice: 'Picture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    # @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      #current_user.create_activity(@picture, 'deleted')
      format.html { redirect_to album_pictures_url(@album) }
      format.json { head :no_content }
    end
  end

  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  def page_title
    "RS " + @user.profile_name + "'s albums"
  end

  private

  def ensure_proper_user
    if current_user != @user
      flash[:error] = "You do not have premission to do that."
      redirect_to album_pictures_path
    end
  end

  def add_breadcrumbs
    add_breadcrumb @user.first_name, profile_path(@user)
    add_breadcrumb "Albums", albums_path
    add_breadcrumb "Pictures", album_pictures_path(@album)
  end

  def find_user
    @user = User.find_by_profile_name(params[:profile_name])
  end

  # if the current users profile name matches the profile name sent with the parameters it shows
  # the pictures of the current user, else it shows the pictures of the user instance variable
  def find_album
    if signed_in? && current_user.profile_name == params[:profile_name]
      @album = current_user.albums.find(params[:album_id])
    else
      @album = @user.albums.find(params[:album_id])
    end
  end
  # @album = @user.albums.find(params[:album_id])

  def find_picture
    @picture = @album.pictures.find(params[:id])
  end


end
