// ignore_for_file: prefer_const_constructors

import 'package:beamer/src/beamer.dart';
import 'package:blueberry/data/item_model.dart';
import 'package:blueberry/data/user_model.dart';
import 'package:blueberry/router/location.dart';
import 'package:blueberry/screens/chat/chat_list_page.dart';
import 'package:blueberry/screens/home/items_page.dart';
import 'package:blueberry/screens/home/map_page.dart';
import 'package:blueberry/states/user_provider.dart';
import 'package:blueberry/utils/logger.dart';
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
    UserModel? userModel = context.read<UserProvider>().userModel;
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
        body: (userModel == null)
            ? Container(
                child: Center(
                  child: ElevatedButton(
                    child: Text("????????????"),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              )
            : Center(
                child: IndexedStack(
                index: _selectedIndex,
                children: [
                  ItemsPage(
                    userKey: userModel.userKey,
                  ),
                  MapPage(userModel),
                  ChatListPage(),
                  Text("profile")
                ],
              )),
        bottomNavigationBar: BottomNavigationBar(
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home), label: "??????"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.where_to_vote), label: "??? ??????"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble), label: "??????"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "?????????")
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
              onPressed: () {
                context.beamToNamed('/$LOCATION_SEARCH');
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                context.beamToNamed('/');
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
