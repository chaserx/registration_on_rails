require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Account.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['account_id']
  end
  
  def test_create_valid
    Account.stubs(:authenticate).returns(Account.first)
    post :create
    assert_redirected_to root_url
    assert_equal Account.first.id, session['account_id']
  end
end
