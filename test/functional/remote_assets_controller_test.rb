require 'test_helper'

class RemoteAssetsControllerTest < ActionController::TestCase
  test "should get index of in progress processes" do
    get :index, :format => 'json'
    assert_response :success
    assert_equal assigns(:remote_assets), [remote_assets(:two), remote_assets(:three)] 
    assert_equal [remote_assets(:two), remote_assets(:three)].to_json, @response.body
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create remote_asset" do
    assert_difference('RemoteAsset.count') do
      post :create, :remote_asset => {:mime_from => 'jpeg', :filename => 'filename', :source_url => "#{RAILS_ROOT}/tmp/hallway.jpg"}, :format => 'json'
    end
    asset = JSON.parse(@response.body)
    assert_equal asset['result'], 1
  end


  test "should show remote_asset" do
    get :show, :id => remote_assets(:one).to_param
    assert_response :success
  end

  test "should show remote asset in json" do
    get :show, :id => remote_assets(:one).to_param, :format => 'json'
    response = JSON.parse(@response.body)
    assert_equal remote_assets(:one).id, response['remote_asset']['id']
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
