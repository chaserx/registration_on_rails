require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Account.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Account.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
    assert_equal assigns['account'].id, session['account_id']
  end
end
