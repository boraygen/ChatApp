import 'package:chat_app/shared/components/default_app_bar.dart';
import 'package:chat_app/shared/shared.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({ Key key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String searchText;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: defaultAppBar(
        title: "",
        actions: 
        [
          Padding(
            padding: EdgeInsets.only(right: size.width < size.height ? 50 : 200),
            child: SizedBox(
              width: size.width < size.height ? size.width * 0.7 : size.height * 0.9,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 8, top: 16),
                  hintText: "search anything",
                  suffixIcon: const Icon(Icons.search_rounded, color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kMainColor),
                  ),
                ),
                onChanged: (value) => setState(() => searchText = value),                
              ),
            ),
          ), 
        ]
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(45),
        //   child: Container(
        //     padding: EdgeInsets.symmetric(horizontal: 80),
        //     margin: EdgeInsets.only(bottom: 9),
        //     child: TextFormField(
        //       decoration: const InputDecoration(
        //         contentPadding: EdgeInsets.only(top: 16),
        //         hintText: "search anything",
        //         suffixIcon: Icon(Icons.search_rounded, color: Colors.white),
        //       ),
        //     ),
        //   ), 
        // )
      ),
    );
  }
}