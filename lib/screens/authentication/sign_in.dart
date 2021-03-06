import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/choose_user_name.dart';
import 'package:chat_app/screens/authentication/components/log_big_button.dart';
import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
import 'package:chat_app/screens/authentication/components/log_form_field.dart';
import 'package:chat_app/screens/authentication/components/log_underlined_text_button.dart';
import 'package:chat_app/screens/authentication/components/show_hide_password_icon_button.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/shared/colors.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({ Key key, @required this.tabController,}) : super(key: key);

  final TabController tabController; 
  final Auth auth = Auth();
  final Database database = Database();


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String inEmail = "";
  String inPw = "";
  bool hidePassword = true;
  bool isLoadingEmail = false;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return StreamProvider<List<UserModel>>.value(
      value: Database().users,
      child: SingleChildScrollView(  // sign in page
        child: Padding(
          padding: const EdgeInsets.only(
            left: kDefaultPadding * 1.5,
            right: kDefaultPadding * 1.5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: kDefaultPadding),
              //const LogSubtitle(subtitle: "Sign In:"),
              SizedBox(height: size.height * 0.158,),
              LogFormField( // email
                text: "email",
                isPw: false,
                onChanged: (value) => setState(() => inEmail = value),      
              ),
              Row(  // password
                children: [
                  Flexible(
                    child: LogFormField( 
                      text: "password", 
                      isPw: hidePassword,
                      onChanged: (value) => setState(() => inPw = value),
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
                    text: "Don't have an account?",
                    press: () 
                    { 
                      widget.tabController.animateTo(
                        1, 
                        duration: const Duration(milliseconds: 500), 
                        curve: Curves.ease,
                      );
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
              isLoadingEmail ? LogBigButtonLoading(color: kMainColor) : LogBigButton( // sign in button
                text: "Sign In",
                press: () async
                {
                  Feedback.forTap(context);
                  if(validateBeforeLog(context, inEmail.trim(), inPw, null) == true)
                  {
                    setState(() => isLoadingEmail = true);
                    var result = await widget.auth.signInWithEmailAndPw(context, inEmail.trim(), inPw);
                    
                    if (result == null)
                    {
                      setState(() => isLoadingEmail = false);
                    }
                    else
                    {
                      checkAndPush(context, result);
                      setState(() => isLoadingEmail = false);
                      customSnackBar(
                        context: context, 
                        type: 1, 
                        text: "Signed in successfully!"
                      );
                    }
                  }
                },
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
    );
  }

  Future checkAndPush(BuildContext context, dynamic result) async
  {
    var route = await widget.database.doesDocExist(result) ? Home(user: result) : ChooseUserName(user: result);

    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => route));
  }
}

