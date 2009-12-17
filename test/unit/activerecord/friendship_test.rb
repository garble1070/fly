require File.dirname(__FILE__) + '/../../test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def tests_exists?
    @user1 = User.find(15)
    @user2 = User.find(16)
    @user3 = User.find(17)
    assert_equal(Friendship.exists?(@user1,@user2),true)
    assert_equal(Friendship.exists?(@user2,@user3),false)
  end
  
  def test_request_accept_breakup
    @user1 = User.find(15)
    @user2 = User.find(16)
    @user3 = User.find(17)
    assert_equal(Friendship.request(@user1,@user1),nil)
    assert_equal(Friendship.request(@user1,@user2),nil)
    @f_obj = Friendship.request(@user2,@user3)
    assert @f_obj.id > 0
    request = Friendship.find_by_user_id_and_friend_id(@user2, @user3)
    assert_equal(request.status,'pending') 
    request = Friendship.find_by_user_id_and_friend_id(@user3, @user2)
    assert_equal(request.status,'requested')
    Friendship.accept(@user3,@user2)
    request = Friendship.find_by_user_id_and_friend_id(@user3, @user2)
    assert_equal(request.status,'accepted') 
    assert_equal(Friendship.exists?(@user2,@user3),true)
    Friendship.breakup(@user2,@user3)
    assert_equal(Friendship.exists?(@user2,@user3),false)
  end
  
  
end
