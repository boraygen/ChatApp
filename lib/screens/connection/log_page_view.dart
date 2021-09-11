import 'package:chat_app/screens/connection/components/log_big_button.dart';
import 'package:chat_app/screens/connection/components/log_bottom_nav_bar.dart';
import 'package:chat_app/screens/connection/components/log_form_field.dart';
import 'package:chat_app/screens/connection/components/log_subtitle.dart';
import 'package:chat_app/screens/connection/components/log_underlined_text_button.dart';
// import 'package:chat_app/screens/connection/sign_in.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogPageView extends StatefulWidget {
  const LogPageView({ Key key }) : super(key: key);

  @override
  _LogPageViewState createState() => _LogPageViewState();
}

class _LogPageViewState extends State<LogPageView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String inEmail;
  String inPw;
  String upEmail;
  String upPw;
  String upPwConfirm;
  var controller = PageController();
  TextStyle signInTextStyle;
  TextStyle registerTextStyle;
  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final focusedSignInTextStyle = TextStyle(
      color: kMainColor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
    final focusedRegisterTextStyle = TextStyle(
      color: kAccentColor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );
    final unFocusedTextStyle = TextStyle(
      color: kPrimaryTextColor,
      fontSize: 13.5,
    );
    


    return Scaffold(
      key: _scaffoldKey,
      appBar: mainAppBar(_scaffoldKey),
      endDrawer: menuDrawer(
        size: size,
        modeSwitch: (_) => setState(() => changeMode()),
      ),
      body: PageView(
        onPageChanged: (page){
          setState(() {
            if(page == 0)
            {
              signInTextStyle = focusedSignInTextStyle;
              registerTextStyle = unFocusedTextStyle;
            }
            else
            {
              signInTextStyle = unFocusedTextStyle;
              registerTextStyle = focusedRegisterTextStyle;
            }
          });
        },
        controller: controller,
        children: [
          SingleChildScrollView(  // sign in page
            child: Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding * 1.5,
                right: kDefaultPadding * 1.5,
                //bottom: kDefaultPadding * 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogSubtitle(subtitle: "Sign In:"),
                  SizedBox(height: size.height * 0.15,),
                  LogFormField( // email
                    text: "email",
                    isPw: false,
                    onChanged: (value) => setState(() => inEmail = value),      
                  ),
                  LogFormField( // password
                    text: "password", 
                    isPw: true,
                    onChanged: (value) => setState(() => inPw = value),
                  ),
                  const SizedBox(height: 15,),
                  Row(  // underlined text buttons
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogUnderlinedTextButton(
                        text: "Don't have an account?",
                        press: () 
                        { 
                          controller.animateToPage(
                            1, 
                            duration: const Duration(milliseconds: 500), 
                            curve: Curves.ease,
                          );
                          // setState(() => title = "Register:");
                        } 
                      ),
                      LogUnderlinedTextButton(
                        text: "Forgot your password?",
                        press: () 
                        { 
                          
                        } 
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  LogBigButton( // sign in button
                    text: "Sign In",
                    press: (){},
                    buttonColor: kMainColor,
                    textColor: darkPrimaryTextColor,
                  ),
                  LogBigButton( // sign in with google button
                    text: "Sign In with Google",
                    press: (){},
                    buttonColor: darkPrimaryTextColor.withOpacity(0.95),
                    textColor: darkSecondaryTextColor,
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(  // register page
            child: Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding * 1.5,
                right: kDefaultPadding * 1.5,
                //bottom: kDefaultPadding * 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogSubtitle(subtitle: "Register:"),
                  SizedBox(height: size.height * 0.15,),
                  LogFormField( // email
                    text: "email",
                    isPw: false,
                    onChanged: (value) => setState(() => upEmail = value),
                  ),
                  Row(  // pw row
                    children: [
                      Flexible( // reg password
                        child: LogFormField(
                          text: "password", 
                          isPw: true,
                          onChanged: (value) => setState(() => upPw = value), 
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Flexible( // reg confirm password
                        child: LogFormField(
                          text: "confirm password", 
                          isPw: true,
                          onChanged: (value) => setState(() => upPwConfirm = value), 
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  Row(  // underlined text buttons
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogUnderlinedTextButton(
                        text: "Already have an account?",
                        press: () 
                        { 
                          controller.animateToPage(
                            0, 
                            duration: const Duration(milliseconds: 500), 
                            curve: Curves.ease,
                          );
                          // setState(() => title = "Sign In:");
                        } 
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                  LogBigButton( // register button
                    text: "Register",
                    press: ()
                    {
                      if(upPw != upPwConfirm)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar(error: "Passwords don't match!")
                        );
                      }
                      if(upPw.length < 6)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          errorSnackBar(error: "Password must be at least 6 characters long!")
                        );
                      }
                    },
                    buttonColor: kAccentColor,
                    textColor: darkPrimaryTextColor,
                  ),
                  LogBigButton( // register with google button
                    text: "Register with Google",
                    press: ()
                    {
                      
                    },
                    buttonColor: darkPrimaryTextColor.withOpacity(0.95),
                    textColor: darkSecondaryTextColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: LogBottomNavBar(
        controller: controller, 
        signInTextStyle: signInTextStyle, 
        focusedSignInTextStyle: focusedSignInTextStyle, 
        registerTextStyle: registerTextStyle,
        unFocusedTextStyle: unFocusedTextStyle,
      ),
    );
  }
}





