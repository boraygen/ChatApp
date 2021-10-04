// import 'package:chat_app/shared/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:chat_app/models/user_model.dart';
// import 'package:chat_app/screens/authentication/components/log_big_button.dart';
// import 'package:chat_app/screens/authentication/components/log_big_button_loading.dart';
// import 'package:chat_app/screens/authentication/components/log_form_field.dart';
// import 'package:chat_app/screens/authentication/components/logout_icon_button.dart';
// import 'package:chat_app/services/database.dart';
// import 'package:chat_app/shared/components/default_app_bar.dart';
// import 'package:chat_app/shared/shared.dart';
// import 'package:chat_app/shared/widgets.dart';

// class SendFriendRequest extends StatefulWidget {
//   const SendFriendRequest({ Key key, @required this.user,}) : super(key: key);

//   final UserModel user;
//   //final Auth auth = Auth();

//   @override
//   _SendFriendRequestState createState() => _SendFriendRequestState();
// }

// class _SendFriendRequestState extends State<SendFriendRequest> {
    
//   String emailVerificationCode = "";
//   String tempUsername = "";
//   String tempUserNameId = "";
//   Database database = Database();
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
    
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: defaultAppBar(
//         actions: 
//         [
//           LogoutIconButton(),
//         ],
//         bottom: null
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: kDefaultPadding * 1.5, 
//             right: kDefaultPadding * 1.5
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 182,),
//               Container(
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,
//                 vertical: kDefaultPadding * 0.5),
//                 height: 180,
//                 margin: EdgeInsets.symmetric(horizontal: size.width < size.height ? 0 : size.width * 0.17 ),
//                 decoration: BoxDecoration(
//                   color: kThemeColor.withAlpha(60),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Text(
//                           "Enter the username: "
                        
//                         ),
//                         Flexible(
//                           child: LogFormField(
//                             text: "username", 
//                             onChanged: (value) => setState(() => tempUsername = value), 
//                             isPw: false
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Text(
//                           "Enter the ID: "
                        
//                         ),
//                         SizedBox(
//                           width: 70,
//                           child: LogFormField(
//                             text: "####", 
//                             onChanged: (value) => setState(() => tempUserNameId = value), 
//                             isPw: false,
//                             inputType: const TextInputType.numberWithOptions(),
//                           ),
//                         ),
//                       ],
//                     ),
                    
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15,),
//               _isLoading ? LogBigButtonLoading(color: kMainColor) : LogBigButton( // set username
//               text: "Send Friend Request",
//               press: () async
//               {
//                 Feedback.forTap(context);
//                 setState(() => _isLoading = true);
//                 var result = await Database(uid: widget.user.uid).sendFriendRequest(
//                   username: tempUsername,
//                   usernameId: tempUserNameId,
//                 );
                
//                 if (result == null)
//                 {
//                   setState(() => _isLoading = false);
//                 }
//                 else
//                 {
//                   setState(() => _isLoading = false);
//                   customSnackBar(
//                     context: context, 
//                     type: 1, 
//                     text: "Friend request sent!"
//                   );
//                 }
//               },
//               buttonColor: kMainColor,
//               textColor: darkPrimaryTextColor,
//             ),
//             ],
//           ),
//         ),
//       ),
      
//     );
//   }
// }

