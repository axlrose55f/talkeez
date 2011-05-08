require 'test_helper'

class GenresControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:genres)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_genre
    assert_difference('Genre.count') do
      post :create, :genre => { }
    end

    assert_redirected_to genre_path(assigns(:genre))
  end

  def test_should_show_genre
    get :show, :id => genres(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => genres(:one).id
    assert_response :success
  end

  def test_should_update_genre
    put :update, :id => genres(:one).id, :genre => { }
    assert_redirected_to genre_path(assigns(:genre))
  end

  def test_should_destroy_genre
    assert_difference('Genre.count', -1) do
      delete :destroy, :id => genres(:one).id
    end

    assert_redirected_to genres_path
  end
end
