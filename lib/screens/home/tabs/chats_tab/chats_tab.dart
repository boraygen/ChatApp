import 'package:chat_app/screens/home/components/message_room_tile.dart';
import 'package:flutter/material.dart';

class ChatsTab extends StatefulWidget {
  const ChatsTab({ Key key }) : super(key: key);

  @override
  _ChatsTabState createState() => _ChatsTabState();
}

class _ChatsTabState extends State<ChatsTab> {
  @override
  Widget build(BuildContext context) {
    return ListView( // WRAP THIS WITH STREAMBUILDER TO GET THE CHATROOMS DOC OF THE CURRENT USER
      scrollDirection: Axis.vertical,
      children: [
        MessageRoomTile(),
        MessageRoomTile(),
        MessageRoomTile(),
        MessageRoomTile(),
        MessageRoomTile(),
        MessageRoomTile(),
        MessageRoomTile(),
        
      ],
    );
  }
}