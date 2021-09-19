import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

customSnackBar({BuildContext context, String text, int type}) {
  //-1 for error, 0 for info, 1 for success

  Widget icon;
  switch (type) {
    case -1:
      icon = const Icon(Icons.error_outline_rounded, color: Colors.red);
      break;
      case 0:
      icon = const Icon(Icons.info_outline_rounded, color: Colors.blue);
      break;
      case 1:
      icon = const Icon(Icons.check_circle_outline_rounded, color: Colors.green);
      break;
  }

  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      content: SizedBox(
        height: 25,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8,),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}



Container menuDrawer({Size size, Function modeSwitch}) {
  return Container(
    width: size.width * 0.6,
    //height: size.height * 0.8,
    padding: EdgeInsets.only(bottom: size.height * 0.2),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25))
    ),
    child: Drawer( // ????
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 9,),
            const Divider(height: 14, thickness: 2.2,),
            // MenuListViewItem(
            //   onTap: null,
            //   child: Row(
            //     children: [
            //       Text(
            //         "Theme:",
            //         style: TextStyle(
            //           fontSize: 15.5,
            //           color: kPrimaryTextColor,
            //         ),
            //       ),
            //       Switch(
            //         activeColor: kMainColor,
            //         value: kDarkMode, 
            //         onChanged: modeSwitch,
            //       ),
            //       kModeIcon,
            //     ],
            //   ),
            // ),
            MenuListViewItem(
              onTap: (){},
              child: Text(
                "About",
                style: TextStyle(
                  fontSize: 15.5,
                  color: kPrimaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MenuListViewItem extends StatelessWidget {
  const MenuListViewItem({
    Key key, this.child, this.onTap,
  }) : super(key: key);

  final Widget child;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: GestureDetector(
        //onLongPress: onLongPress,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

AppBar mainAppBar(GlobalKey<ScaffoldState> key) {
  return AppBar(
    title: const Text(
      "Chat App",
    ),
    actions: [
      IconButton( // ????
        icon: const Icon(Icons.menu),
        color: kPrimaryTextColor,
        onPressed: () => key.currentState.openEndDrawer(),
      )
    ],
  );
}