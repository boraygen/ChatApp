import 'dart:math';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class MessageRoomTile extends StatelessWidget {
  const MessageRoomTile({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: (){ },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          //horizontal: kDefaultPadding * 0.1,
          vertical: 5,   
        ),
        width: size.width,
        height: 69,
        child: Row(
          children: [
            const Icon(Icons.account_circle_rounded, size: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(
                width: size.width < size.height ? size.width * 0.75 : size.width * 0.81,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.57,
                          child: Text(
                            "123456789012345678999990",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryTextColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "99/99/99",
                            style: TextStyle(
                              color: kPrimaryTextColor.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.62,
                          child: Text(
                            "messagemessagemessagemessagemessagemessage",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              color: kPrimaryTextColor.withOpacity(0.8)
                            ),  
                          ),
                        ),
                        Transform.rotate(
                          angle: 45 * pi / 180,
                          child: Icon(
                            Icons.push_pin_outlined, 
                            size: 20,
                            color: kPrimaryTextColor.withOpacity(0.6),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    
          ],
        ),
      ),
    );
  }
}

