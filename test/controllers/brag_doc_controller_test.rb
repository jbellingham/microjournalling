require "test_helper"

class BragDocControllerTest < ActionDispatch::IntegrationTest
  test "should get export" do
    get brag_doc_export_url
    assert_response :success
  end
end
