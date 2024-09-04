require "test_helper"

class ArticulosControllerTest < ActionDispatch::IntegrationTest
  test 'render a list of articles' do
    get '/'
    assert_response :success
    #  assert_select '.article', 2
  end
end
