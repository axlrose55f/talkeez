require 'test_helper'

class TriviasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:trivias)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_trivia
    assert_difference('Trivia.count') do
      post :create, :trivia => { }
    end

    assert_redirected_to trivia_path(assigns(:trivia))
  end

  def test_should_show_trivia
    get :show, :id => trivias(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => trivias(:one).id
    assert_response :success
  end

  def test_should_update_trivia
    put :update, :id => trivias(:one).id, :trivia => { }
    assert_redirected_to trivia_path(assigns(:trivia))
  end

  def test_should_destroy_trivia
    assert_difference('Trivia.count', -1) do
      delete :destroy, :id => trivias(:one).id
    end

    assert_redirected_to trivias_path
  end
end
