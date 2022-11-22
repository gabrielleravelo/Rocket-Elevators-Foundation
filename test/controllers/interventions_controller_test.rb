require 'test_helper'

class InterventionsControllerTest < ActionDispatch::IntegrationTest
  test "should get interventionform" do
    get interventions_interventionform_url
    assert_response :success
  end

end
