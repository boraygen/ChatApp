import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';


class LogBottomNavBar extends StatelessWidget {
  const LogBottomNavBar({
    Key key,
    @required this.controller,
    @required this.signInTextStyle,
    @required this.focusedSignInTextStyle,
    @required this.registerTextStyle,
    @required this.unFocusedTextStyle,
  }) : super(key: key);

  final PageController controller;
  final TextStyle signInTextStyle;
  final TextStyle focusedSignInTextStyle;
  final TextStyle registerTextStyle;
  final TextStyle unFocusedTextStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SizedBox(
        //width: size.width * 0.4,
        height: 60,
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("<"),
              BottomNavButton(
                controller: controller, 
                defaultTextStyle: signInTextStyle, 
                ifNullTextStyle: focusedSignInTextStyle,
                text: "Sign In",
                onTap: (){
                  controller.animateToPage(
                    0, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.ease,
                  );
                  //setState(() => isPageSignIn = false);
                },
              ),
              const SizedBox(width: 70,),
              BottomNavButton(
                controller: controller, 
                defaultTextStyle: registerTextStyle, 
                ifNullTextStyle: unFocusedTextStyle,
                text: "Register",
                onTap: (){
                  controller.animateToPage(
                    1, 
                    duration: const Duration(milliseconds: 500), 
                    curve: Curves.ease,
                  );
                  //setState(() => isPageSignIn = false);
                },
              ),
              const Text(">"),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key key, 
    this.controller, 
    this.defaultTextStyle, 
    this.ifNullTextStyle, 
    this.text,
    this.onTap,
  }) : super(key: key);

  final PageController controller;
  final TextStyle defaultTextStyle;
  final TextStyle ifNullTextStyle;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // bottom sign up
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        height: 40,
        width: 98,
        child: Text(
          text,
          style: defaultTextStyle ?? ifNullTextStyle,
        ),
      ),
    );
  }
}
