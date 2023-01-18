import 'package:chat_app/ui/screens/new_contact.dart';
import 'package:chat_app/ui/themes/color.dart';
import 'package:chat_app/ui/widgets/list_contacts.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: CustomColors.green,
              radius: 25.0,
              child: Icon(
                Icons.group,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text(
              'New group',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ListTile(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => NewContactScreen(),
                ),
              );
            },
            leading: const CircleAvatar(
              backgroundColor: CustomColors.green,
              radius: 25.0,
              child: Icon(
                Icons.person_add,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            title: Text(
              'New contact',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: CustomColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            'Contacts',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Colors.blueGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  for (var i = 0; i < 10; i++)
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 25.0,
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200"),
                      ),
                      title: Text(
                        "amile",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: CustomColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ))
        ],
      ),
    );
  }
}
