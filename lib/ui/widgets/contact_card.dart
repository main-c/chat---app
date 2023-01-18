import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/themes/color.dart';
import 'package:flutter/material.dart';

import '../../services/instance.dart';

class ContactCard extends StatefulWidget {
  ContactCard({super.key, required this.contact});

  Contact contact;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  bool isInCircle = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(widget.contact.imageUrl),
          ),
          title: Text(
            widget.contact.username,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                color: CustomColors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          trailing: TextButton(
            onPressed: () {
              if (isInCircle) {
                return;
              }
              _sendInvitation(widget.contact.username);
            },
            child: isInCircle
                ? Text("")
                : Container(
                    width: 100.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: CustomColors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: CustomColors.secondGreen,
                          )
                        : Text(
                            'Send Invitation',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                          ),
                  ),
          )),
    );
  }

  void _sendInvitation(String name) {
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Request.client
        .get(endpoint: "/invitation/new/$name", params: {}).then((value) {
      setState(() {
        isLoading = false;

        if (value.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invitation sent"),
            backgroundColor: CustomColors.secondGreen,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Invitation failed"),
            backgroundColor: Colors.red,
          ));
        }
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }
}
