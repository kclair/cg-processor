require 'test_helper'

class RemoteAssetsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:remote_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remote_asset" do
    assert_difference('RemoteAsset.count') do
      post :create, :asset => {:mime_from => 'jpeg', :filename => 'filename'}.to_json, :format => 'json'
    end
    asset = JSON.parse(@response.body)
    assert_equal asset['result'], 1
  end

  test "should show remote_asset" do
    get :show, :id => remote_assets(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => remote_assets(:one).to_param
    assert_response :success
  end

  test "should update remote_asset" do
    put :update, :id => remote_assets(:one).to_param, :remote_asset => { }
    assert_redirected_to remote_asset_path(assigns(:remote_asset))
  end

  test "should destroy remote_asset" do
    assert_difference('RemoteAsset.count', -1) do
      delete :destroy, :id => remote_assets(:one).to_param
    end

    assert_redirected_to remote_assets_path
  end
end
