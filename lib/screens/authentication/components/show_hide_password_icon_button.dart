import 'package:flutter/material.dart';

class ShowHidePasswordIconButton extends StatelessWidget {
  const ShowHidePasswordIconButton({
    Key key,
    @required this.hidePassword,
    @required this.onTap,
  }) : super(key: key);

  final bool hidePassword;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container( 
      //margin: EdgeInsets.only(right: 15),// show/hide password
      height: 37,
      width: 30,
      child: GestureDetector(
        child: hidePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
        onTap: onTap
      ),
    );
  }
}