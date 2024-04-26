import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // If you are using Firebase UI Auth components in other parts of your app, keep this
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'homepage.dart';
import 'profile.dart';
import 'setting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const ProfilePage(),  // Utilisation du nouveau widget ProfilePage    
    const HomePage(),  // Updated the content to match the new icon labels
    const SettignPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(  
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Parameters',
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages,
      ),
    );
  }
}
