import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_project/firebase_options.dart';
import 'package:new_project/provider/user_provider.dart';
import 'package:new_project/responsive/mobilescreen.dart';
import 'package:new_project/responsive/responsive.dart';
import 'package:new_project/responsive/webscreen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:new_project/screens/sign_in.dart';
import 'package:new_project/shared/snackbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDOIrkYeC8uOAtVtzLNxslI-Jz0zfMO2JQ",
            authDomain: "insta-app-51cc9.firebaseapp.com",
            projectId: "insta-app-51cc9",
            storageBucket: "insta-app-51cc9.appspot.com",
            messagingSenderId: "131525740165",
            appId: "1:131525740165:web:117affb5116e42de674bec"));
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) {
          return UserProvider(); // this another wat to get user data from database
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return const Responsive(
                    mobileScreen: MobileScreen(), webScreen: WebScreen());
              } else {
                return const Login();
              }
            },
          ),
        ));
  }
}
