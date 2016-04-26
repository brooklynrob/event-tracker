require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get mapsearch" do
    get :mapsearch
    assert_response :success
  end

end
