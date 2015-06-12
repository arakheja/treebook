class BreakingNewsController < ApplicationController
  # GET /breaking_news
  # GET /breaking_news.json
  def index
    @breaking_news = BreakingNews.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @breaking_news }
    end
  end

  # GET /breaking_news/1
  # GET /breaking_news/1.json
  def show
    @breaking_news = BreakingNews.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @breaking_news }
    end
  end

  # GET /breaking_news/new
  # GET /breaking_news/new.json
  def new
    @breaking_news = BreakingNews.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @breaking_news }
    end
  end

  # GET /breaking_news/1/edit
  def edit
    @breaking_news = BreakingNews.find(params[:id])
  end

  # POST /breaking_news
  # POST /breaking_news.json
  def create
    @breaking_news = BreakingNews.new(params[:breaking_news])

    respond_to do |format|
      if @breaking_news.save
        format.html { redirect_to @breaking_news, notice: 'Breaking news was successfully created.' }
        format.json { render json: @breaking_news, status: :created, location: @breaking_news }
      else
        format.html { render action: "new" }
        format.json { render json: @breaking_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /breaking_news/1
  # PUT /breaking_news/1.json
  def update
    @breaking_news = BreakingNews.find(params[:id])

    respond_to do |format|
      if @breaking_news.update_attributes(params[:breaking_news])
        format.html { redirect_to @breaking_news, notice: 'Breaking news was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @breaking_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breaking_news/1
  # DELETE /breaking_news/1.json
  def destroy
    @breaking_news = BreakingNews.find(params[:id])
    @breaking_news.destroy

    respond_to do |format|
      format.html { redirect_to breaking_news_index_url }
      format.json { head :no_content }
    end
  end
end
