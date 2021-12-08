// ignore_for_file: prefer_const_constructors

import 'package:beamer/src/beamer.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/home/items_page.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/widgets/expandable_fab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _widgetOptions = <Widget>[
      ItemsPage(),
      Text("Location"), //the Text widgets will change a page class
      Text("chatting"),
      Text("profile")
    ];

    return SafeArea(
      child: Scaffold(
        floatingActionButton: ExpandableFab(distance: 90, children: [
          MaterialButton(
            color: Colors.purple,
            elevation: 4.0,
            onPressed: () {},
            shape: CircleBorder(),
            height: 40,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          MaterialButton(
            color: Colors.purple,
            elevation: 4.0,
            onPressed: () {
              context.beamToNamed('/$LOCATION_INPUT');
            },
            shape: CircleBorder(),
            height: 40,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ]),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "피드"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.where_to_vote), label: "내 위치"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble), label: "채팅"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "프로필")
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey[400],
          showUnselectedLabels: true,
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
