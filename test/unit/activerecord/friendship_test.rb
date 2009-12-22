require File.dirname(__FILE__) + '/../../test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def tests_exists?
    load_instance_vars

    assert_equal(Friendship.exists?(@user_15,@user_16),true)
    assert_equal(Friendship.exists?(@user_16,@user_17),false)
  end
  
  def test_request_accept_breakup
    load_instance_vars
    assert_equal(Friendship.request(@user_15,@user_15),nil)
    assert_equal(Friendship.request(@user_15,@user_16),nil)

    @f_obj = Friendship.request(@user_16,@user_17)
    assert @f_obj.id > 0

    request = Friendship.find_by_user_id_and_friend_id(@user_16, @user_17)
    assert_equal(request.status,'pending') 

    request = Friendship.find_by_user_id_and_friend_id(@user_17, @user_16)
    assert_equal(request.status,'requested')

    Friendship.accept(@user_17,@user_16)
    request = Friendship.find_by_user_id_and_friend_id(@user_17, @user_16)
    assert_equal(request.status,'accepted') 
    assert_equal(Friendship.exists?(@user_16,@user_17),true)

    Friendship.breakup(@user_16,@user_17)
    assert_equal(Friendship.exists?(@user_16,@user_17),false)
  end
  
  
end
