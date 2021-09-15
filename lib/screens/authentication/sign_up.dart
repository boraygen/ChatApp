import 'package:chat_app/screens/authentication/choose_user_name.dart';
import 'package:chat_app/screens/authentication/components/log_big_button.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/authentication/components/log_form_field.dart';
import 'package:chat_app/screens/authentication/components/log_subtitle.dart';
import 'package:chat_app/screens/authentication/components/log_underlined_text_button.dart';
import 'package:chat_app/screens/authentication/components/show_hide_password_icon_button.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({ Key key, @required this.tabController, @required this.auth, }) : super(key: key);

  final TabController tabController;
  final Auth auth;

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String upEmail = "";
  String upPw = "";
  String upPwConfirm = "";
  bool hidePassword = true;
  bool isLoadingEmail = false;
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(  // register page
      child: Padding(
        padding: const EdgeInsets.only(
          left: kDefaultPadding * 1.5,
          right: kDefaultPadding * 1.5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: kDefaultPadding),
            //const LogSubtitle(subtitle: "Register:"),
            SizedBox(height: size.height * 0.158,),
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
                    isPw: hidePassword,
                    onChanged: (value) => setState(() => upPw = value), 
                  ),
                ),
                const SizedBox(width: 15,),
                Flexible( // reg confirm password
                  child: LogFormField(
                    text: "confirm password", 
                    isPw: hidePassword,
                    onChanged: (value) => setState(() => upPwConfirm = value), 
                  ),
                ),
                ShowHidePasswordIconButton(
                  hidePassword: hidePassword, 
                  onTap: () 
                  {
                    Feedback.forTap(context);
                    setState(() => hidePassword = !hidePassword);
                  },
                )
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
                    widget.tabController.animateTo(
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
            isLoadingEmail ? LogBigButtonLoading(color: kAccentColor): LogBigButton( // register button
              text: "Register",
              press: () async
              {
                Feedback.forTap(context);
                if(validateBeforeLog(context, upEmail, upPw, upPwConfirm) == true)
                {
                  setState(() => isLoadingEmail = true);
                  // widget.auth.signUpWithEmailAndPw(upEmail, upPw).then(
                  //   (value) 
                  //   {
                  //     setState(() => isLoading = false);
                  //   }
                  // );
                  var result = await widget.auth.signUpWithEmailAndPw(context, upEmail, upPw);
                  if (result == null)
                  {
                    setState(() => isLoadingEmail = false);
                  }
                  else
                  {
                    setState(() => isLoadingEmail = false);
                    customSnackBar(
                      context: context, 
                      type: 1, 
                      text: "Registered successfully!"
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChooseUserName(user: result, auth: widget.auth,)));
                  }
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
    );
  }
}

