require 'test_helper'

class OsVendorsControllerTest < ActionController::TestCase
  setup do
    @os_vendor = os_vendors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:os_vendors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create os_vendor" do
    assert_difference('OsVendor.count') do
      post :create, os_vendor: @os_vendor.attributes
    end

    assert_redirected_to os_vendor_path(assigns(:os_vendor))
  end

  test "should show os_vendor" do
    get :show, id: @os_vendor.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @os_vendor.to_param
    assert_response :success
  end

  test "should update os_vendor" do
    put :update, id: @os_vendor.to_param, os_vendor: @os_vendor.attributes
    assert_redirected_to os_vendor_path(assigns(:os_vendor))
  end

  test "should destroy os_vendor" do
    assert_difference('OsVendor.count', -1) do
      delete :destroy, id: @os_vendor.to_param
    end

    assert_redirected_to os_vendors_path
  end
end
