require 'test_helper'

class BreakingNewsControllerTest < ActionController::TestCase
  setup do
    @breaking_news = breaking_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:breaking_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create breaking_news" do
    assert_difference('BreakingNews.count') do
      post :create, breaking_news: { content: @breaking_news.content, name: @breaking_news.name, title: @breaking_news.title }
    end

    assert_redirected_to breaking_news_path(assigns(:breaking_news))
  end

  test "should show breaking_news" do
    get :show, id: @breaking_news
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @breaking_news
    assert_response :success
  end

  test "should update breaking_news" do
    put :update, id: @breaking_news, breaking_news: { content: @breaking_news.content, name: @breaking_news.name, title: @breaking_news.title }
    assert_redirected_to breaking_news_path(assigns(:breaking_news))
  end

  test "should destroy breaking_news" do
    assert_difference('BreakingNews.count', -1) do
      delete :destroy, id: @breaking_news
    end

    assert_redirected_to breaking_news_index_path
  end
end
