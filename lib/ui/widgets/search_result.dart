import 'package:chat_app/ui/themes/color.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  SearchResult({super.key, required this.query});

  String query;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 5)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
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
        } else {
          return const Center(
            child: CircularProgressIndicator(color: CustomColors.secondGreen),
          );
        }
      },
    );
  }
}
