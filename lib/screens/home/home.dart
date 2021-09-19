import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/logout_icon_button.dart';
import 'package:chat_app/screens/home/components/message_room_tile.dart';
import 'package:chat_app/screens/home/components/search.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key key, @required this.auth , @required this.user}) : super(key: key);

  final UserModel user;
  final Auth auth;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState()
  {
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: defaultAppBar(
        actions: 
        [
          const Padding(
            padding: EdgeInsets.only(top: 7.0),
            child: Align(
              alignment: Alignment.center,
              child: Text("Username" "#" "0000"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: LogoutIconButton(auth: widget.auth),
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          labelPadding: const EdgeInsets.only(bottom: 10,),
          controller: _tabController,
          tabs: const [
            Text("Chats"),
            Text("Friends"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
              MessageRoomTile(),
            ],
          ),
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              MessageRoomTile(),
            ]
          ),
          
          
          
        ],
      ),
      
      
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        elevation: 0,
        child: const Icon(
          Icons.search_rounded,
          color: Colors.white,
          size: 28,
        ),
        onPressed: () => Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => const Search()
          )
        ),
      )
    );
  }
}
