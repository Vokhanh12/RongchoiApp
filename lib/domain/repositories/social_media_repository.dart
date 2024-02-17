abstract class SocialMediaRepository{

  Future<void> addFriendFromNumber();
  Future<void> addFriendFromNickName();
  Future<void> removeFriend();

  Future<void> addPost();
  Future<void> deletePost();
  Future<void> likePost();
  
  Future<void> addComment();
  Future<void> deleteComment();
  Future<void> updateComment();

  Future<void> sendMessage();
  Future<void> getMessages();
  Future<void> deleteMessage();

  Future<void> getNotifications();
  Future<void> deleteNotification();

  Future<void> followStore();
  Future<void> unFollowStore();

}


