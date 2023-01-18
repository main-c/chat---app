import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/instance.dart';
import 'package:chat_app/ui/themes/color.dart';
import 'package:chat_app/ui/widgets/contact_card.dart';
import 'package:chat_app/ui/widgets/contact_searh_delegate.dart';
import 'package:chat_app/ui/widgets/search_result.dart';
import 'package:flutter/material.dart';

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  String _query = '';
  bool isLoading = false;
  List<dynamic> _results = [];
  List<Contact> contact = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('New Contact'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: CustomColors.secondGreen,
                ),
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      _query = value;
                    });
                  }),
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: CustomColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search a contact by username',
                    hintStyle: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.blueGrey,
                          fontSize: 16,
                        ),
                    prefixIcon:
                        const Icon(Icons.search, color: CustomColors.green),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: CustomColors.green),
                      onPressed: () {
                        _query.isEmpty ? null : sendRequest();
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Results',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    backgroundColor: CustomColors.green,
                  ))
                : _results.isEmpty
                    ? const Center(
                        child: Text(
                          'No results',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          return ContactCard(
                              contact: Contact(
                            id: 1,
                            username: _results[index]['login'],
                            imageUrl: 'https://picsum.photos/200/300',
                          ));
                        },
                      ),
            const SizedBox(
              height: 15.0,
            ),
            Text(
              'Invitations received',
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void sendRequest() {
    // Code pour soumettre la recherche

    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    Request.client
        .get(endpoint: "/search/user/$_query", params: {}).then((value) {
      setState(() {
        isLoading = false;

        if (value.statusCode == 200) {
          _results = value.data;
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
