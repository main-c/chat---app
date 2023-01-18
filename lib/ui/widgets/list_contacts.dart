import 'package:flutter/material.dart';

class ListContacts extends StatelessWidget {
  const ListContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage("https://picsum.photos/200"),
          ),
          title: Text('User Name'),
        );
      },
    );
  }
}
