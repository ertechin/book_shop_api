require "test_helper"

class BasketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @basket = baskets(:one)
  end

  test "should get index" do
    get baskets_url, as: :json
    assert_response :success
  end

  test "should create basket" do
    assert_difference("Basket.count") do
      post baskets_url, params: { basket: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show basket" do
    get basket_url(@basket), as: :json
    assert_response :success
  end

  test "should update basket" do
    patch basket_url(@basket), params: { basket: {  } }, as: :json
    assert_response :success
  end

  test "should destroy basket" do
    assert_difference("Basket.count", -1) do
      delete basket_url(@basket), as: :json
    end

    assert_response :no_content
  end
end
