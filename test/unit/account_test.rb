require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def new_account(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    account = Account.new(attributes)
    account.valid? # run validations
    account
  end
  
  def setup
    Account.delete_all
  end
  
  def test_valid
    assert new_account.valid?
  end
  
  def test_require_username
    assert new_account(:username => '').errors.on(:username)
  end
  
  def test_require_password
    assert new_account(:password => '').errors.on(:password)
  end
  
  def test_require_well_formed_email
    assert new_account(:email => 'foo@bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_email
    new_account(:email => 'bar@example.com').save!
    assert new_account(:email => 'bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_username
    new_account(:username => 'uniquename').save!
    assert new_account(:username => 'uniquename').errors.on(:username)
  end
  
  def test_validate_odd_characters_in_username
    assert new_account(:username => 'odd ^&(@)').errors.on(:username)
  end
  
  def test_validate_password_length
    assert new_account(:password => 'bad').errors.on(:password)
  end
  
  def test_require_matching_password_confirmation
    assert new_account(:password_confirmation => 'nonmatching').errors.on(:password)
  end
  
  def test_generate_password_hash_and_salt_on_create
    account = new_account
    account.save!
    assert account.password_hash
    assert account.password_salt
  end
  
  def test_authenticate_by_username
    Account.delete_all
    account = new_account(:username => 'foobar', :password => 'secret')
    account.save!
    assert_equal account, Account.authenticate('foobar', 'secret')
  end
  
  def test_authenticate_by_email
    Account.delete_all
    account = new_account(:email => 'foo@bar.com', :password => 'secret')
    account.save!
    assert_equal account, Account.authenticate('foo@bar.com', 'secret')
  end
  
  def test_authenticate_bad_username
    assert_nil Account.authenticate('nonexisting', 'secret')
  end
  
  def test_authenticate_bad_password
    Account.delete_all
    new_account(:username => 'foobar', :password => 'secret').save!
    assert_nil Account.authenticate('foobar', 'badpassword')
  end
end
