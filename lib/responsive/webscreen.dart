import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_project/screens/add_post.dart';
import 'package:new_project/screens/faviourte.dart';
import 'package:new_project/screens/home.dart';
import 'package:new_project/screens/profile.dart';
import 'package:new_project/screens/search.dart';
import 'package:new_project/shared/colors.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: webBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SvgPicture.asset(
          "assets/images/instagram.svg",
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
              onPressed: () {
                _pageController.jumpToPage(0);
                setState(() {
                  currentPage = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color: currentPage == 0 ? primaryColor : secondaryColor,
              )),
          IconButton(
              onPressed: () {
                _pageController.jumpToPage(1);
                setState(() {
                  currentPage = 1;
                });
              },
              icon: Icon(Icons.search,
                  color: currentPage == 1 ? primaryColor : secondaryColor)),
          IconButton(
              onPressed: () {
                _pageController.jumpToPage(2);
                setState(() {
                  currentPage = 2;
                });
              },
              icon: Icon(Icons.add_a_photo,
                  color: currentPage == 2 ? primaryColor : secondaryColor)),
          IconButton(
              onPressed: () {
                _pageController.jumpToPage(3);
                setState(() {
                  currentPage = 3;
                });
              },
              icon: Icon(Icons.favorite,
                  color: currentPage == 3 ? primaryColor : secondaryColor)),
          IconButton(
              onPressed: () {
                _pageController.jumpToPage(4);
                setState(() {
                  currentPage = 4;
                });
              },
              icon: Icon(Icons.person,
                  color: currentPage == 4 ? primaryColor : secondaryColor)),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {},
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // to disable rwo scrolling
        children: [
          Home(),
          Search(),
          AddPost(),
          Faviourte(),
          Profile(userID: FirebaseAuth.instance.currentUser!.uid),
        ],
      ),
    );
  }
}
