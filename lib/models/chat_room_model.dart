
class ChatRoomModel
{
  final String uid;
  final DateTime dateCreated;
  final String createdBy;
  //String pictureRef;
  List<String> mods;
  String roomName;
  List<String> tabs;
  List<String> topics;
  List<String> users;
  

  ChatRoomModel(
    {
      this.uid, 
      this.createdBy, 
      this.dateCreated,
      this.mods, 
      this.roomName,
      this.tabs,
      this.topics,
      this.users,
      
    }
  );
}