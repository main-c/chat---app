import 'package:chat_app/ui/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/widgets/category_selector.dart';
import 'package:chat_app/ui/widgets/favourite_contacts.dart';
import 'package:chat_app/ui/widgets/recent_chats.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // CategorySelector(),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                ActiveContacts(),
                RecentChats(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
