require 'test_helper'

class RemoteAssetTest < ActiveSupport::TestCase
  
  test "new remote assets should get queued" do
    asset = RemoteAsset.new
    asset.save!
    assert !asset.worker_uuid.nil?
    assert_equal "queued", asset.status
  end

  test "remote asset without source url should fail" do
    asset = RemoteAsset.new
    asset.save!
    asset.process
    assert_equal "failed", asset.status
    assert asset.status_msg =~ /source url blank/
  end

#  test "odt to pdf" do
#    asset = remote_assets(:odt)
#    asset.process
#    puts asset.status_msg
#    assert_equal "succeeded", asset.status
#  end

#  test "test exec" do
#    asset = remote_assets(:test)
#    asset.process
#    assert asset.status_msg =~ /stdout 0\nstderr 0\nstdout 1\nstderr 1/
#  end

  test "exec_fork" do
    asset = remote_assets(:test)
    asset.process
    assert_equal 'succeeded', asset.status
    assert asset.status_msg =~ /hello to stdout/
    assert asset.status_msg =~ /hello to stderr/
  end

end
