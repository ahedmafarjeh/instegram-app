import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/provider/user_provider.dart';
import 'package:new_project/screens/add_post.dart';

import 'package:new_project/screens/faviourte.dart';
import 'package:new_project/screens/home.dart';
import 'package:new_project/screens/profile.dart';
import 'package:new_project/screens/search.dart';
import 'package:new_project/shared/colors.dart';
import 'package:provider/provider.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // To get data from DB using provider
  getDataFromDB() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageView make row scrolling to whole screen
      body: PageView(
        onPageChanged: (index) {},
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // to disable rwo scrolling
        children: [
          const Home(),
          const Search(),
          const AddPost(),
          const Faviourte(),
          Profile(
            userID: FirebaseAuth.instance.currentUser!.uid,
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          _pageController.jumpToPage(index);
          setState(() {
            currentPage = index;
          });
        },
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentPage == 0 ? primaryColor : secondaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: currentPage == 1 ? primaryColor : secondaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: currentPage == 2 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: currentPage == 3 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: currentPage == 4 ? primaryColor : secondaryColor),
              label: ""),
        ],
      ),
    );
  }
}
