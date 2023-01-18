import 'package:chat_app/ui/screens/group_page.dart';
import 'package:chat_app/ui/screens/home_page.dart';
import 'package:chat_app/ui/screens/profile_page.dart';
import 'package:chat_app/ui/screens/contact_page.dart';
import 'package:chat_app/ui/themes/color.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    HomePage(),
    ContactPage(),
    GroupScreen(),
    ProfileScreen()
  ];
  int _selectedPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: const Icon(Icons.menu),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {}),
          title: Center(
            child: Text('Jioni',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
          ),
          elevation: 2.0,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.search),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {}),
          ],
        ),
        body: _pages.elementAt(_selectedPageIndex),
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
              onTap: ((index) => setState(() => _selectedPageIndex = index)),
              currentIndex: _selectedPageIndex,
              selectedItemColor: CustomColors.green,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              backgroundColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contacts),
                  label: 'Contacts',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Groups',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]),
        ));
  }
}
