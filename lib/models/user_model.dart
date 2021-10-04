
import 'package:chat_app/models/friend_model.dart';

class UserModel
{
  String uid;
  String username;
  String usernameId;
  String pictureRef;
  List<String> friendsUid;
  List<FriendModel> friends;
  String status;
  List<String> friendRequests;
  List<String> blocked;

  UserModel(
    {
      this.uid, 
      this.username, 
      this.usernameId, 
      this.friendsUid, 
      this.status,
      this.friendRequests,
      this.blocked,
      this.friends
    }
  );
  // UserModel({this.uid, })
  // {
    
  // }
}