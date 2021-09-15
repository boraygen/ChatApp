import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/authentication/components/log_big_button.dart';
import 'package:chat_app/screens/authentication/components/log_form_field.dart';
import 'package:chat_app/screens/authentication/components/logout_icon_button.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:chat_app/shared/widgets.dart';
import 'package:flutter/material.dart';

class ChooseUserName extends StatefulWidget {
  const ChooseUserName({ Key key, @required this.user, @required this.auth }) : super(key: key);

  final UserModel user;
  final Auth auth;

  @override
  _ChooseUserNameState createState() => _ChooseUserNameState();
}

class _ChooseUserNameState extends State<ChooseUserName> {
    
  String emailVerificationCode = "";
  String tempUsername = "";
  String tempUserNameId = "";

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: defaultAppBar(
        actions: 
        [
          LogoutIconButton(auth: widget.auth),
        ],
        bottom: null
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: kDefaultPadding * 1.5, 
            right: kDefaultPadding * 1.5
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150,),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,
                vertical: kDefaultPadding * 0.5),
                height: 180,
                margin: EdgeInsets.symmetric(horizontal: size.width < size.height ? 0 : size.width * 0.17 ),
                decoration: BoxDecoration(
                  color: kThemeColor.withAlpha(60),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Enter a username: "
                        
                        ),
                        Flexible(
                          child: LogFormField(
                            text: "username", 
                            onChanged: (value) => setState(() => tempUsername = value), 
                            isPw: false
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Enter a 4 digit ID: "
                        
                        ),
                        SizedBox(
                          width: 70,
                          child: LogFormField(
                            text: "####", 
                            onChanged: (value) => setState(() => tempUserNameId = value), 
                            isPw: false,
                            inputType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Enter the code sent to your email: "
                        
                        ),
                        SizedBox(
                          width: 70,
                          child: LogFormField(
                            text: "code", 
                            onChanged: (value) => setState(() => emailVerificationCode = value), 
                            isPw: false
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              LogBigButton( // set username
              text: "Set Username",
              press: ()
              {
                if(tempUserNameId.length == 4 && RegExp(r'^[0-9]+$').hasMatch(tempUserNameId))
                {
                  if(tempUsername.length > 2)
                  {
                    // check if username#id exists in db, 
                    //if not: set temps to User and pushRepl.: Home()
                    customSnackBar(
                      context: context,
                      type: 1,
                      text: "Username and ID have been successfully set!",
                    );
                    Navigator.pushReplacement(context, 
                      MaterialPageRoute(
                        builder: (context) => Home(
                          auth: widget.auth, 
                          user: widget.user 
                        )
                      )
                    );
                  }
                  else
                  {
                    customSnackBar(
                      context: context, 
                      type: -1, 
                      text: "Username must be 3 to 30 characters long!",
                    );
                  }
                }
                else
                {
                  customSnackBar(
                    context: context, 
                    type: -1, 
                    text: "Username ID must be 4 digits!"
                  );
                }

              },
              buttonColor: kAccentColor,
              textColor: darkPrimaryTextColor,
            ),
            ],
          ),
        ),
      ),
      
    );
  }
}

