import 'package:chat_app/screens/authentication/sign_in.dart';
import 'package:chat_app/screens/authentication/sign_up.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:flutter/material.dart';

class LogTabs extends StatefulWidget {
  const LogTabs({ Key key }) : super(key: key);

  
  @override
  _LogTabsState createState() => _LogTabsState();
}

class _LogTabsState extends State<LogTabs> with SingleTickerProviderStateMixin{

  //PageController pageController = PageController();
  TabController _tabController;
  Auth auth = Auth();

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
    return Scaffold(
      appBar: defaultAppBar(
        bottom: TabBar(
          indicatorColor: Colors.white,
          labelPadding: const EdgeInsets.only(bottom: 14,),
          controller: _tabController,
          tabs: const [
            Text("Sign In"),
            Text("Register"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SignIn(tabController: _tabController,),
          SignUp(tabController: _tabController,)
        ],
      ),
    );
  }

  
}