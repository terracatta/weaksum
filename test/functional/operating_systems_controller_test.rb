require 'test_helper'

class OperatingSystemsControllerTest < ActionController::TestCase
  setup do
    @operating_system = operating_systems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:operating_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create operating_system" do
    assert_difference('OperatingSystem.count') do
      post :create, operating_system: @operating_system.attributes
    end

    assert_redirected_to operating_system_path(assigns(:operating_system))
  end

  test "should show operating_system" do
    get :show, id: @operating_system.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @operating_system.to_param
    assert_response :success
  end

  test "should update operating_system" do
    put :update, id: @operating_system.to_param, operating_system: @operating_system.attributes
    assert_redirected_to operating_system_path(assigns(:operating_system))
  end

  test "should destroy operating_system" do
    assert_difference('OperatingSystem.count', -1) do
      delete :destroy, id: @operating_system.to_param
    end

    assert_redirected_to operating_systems_path
  end
end
