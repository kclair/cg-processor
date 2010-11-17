require 'test_helper'

class RemoteAssetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "new remote assets should get queued" do
    asset = RemoteAsset.new
    asset.save!
    assert !asset.worker_uuid.nil?
    assert_equal "queued", asset.status
  end

  test "processing remote asset should set status" do
    asset = RemoteAsset.new
    asset.save!
    asset.process
    assert_equal "failed", asset.status
  end

end
