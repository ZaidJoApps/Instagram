import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:specialinstagram/responsive/mobile_screen_layout.dart';
import 'package:specialinstagram/responsive/responsive_layout.dart';
import 'package:specialinstagram/responsive/web_screen_layout.dart';
import 'package:specialinstagram/screens/login_screen.dart';
import 'package:specialinstagram/screens/signup_screen.dart';
import 'package:specialinstagram/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print ("this is webbbbbbbb!!!!");
    // web
   await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyDP7IwQpWf5HDSM4Le5KUtPvOVV6WjpPRM',
            appId: '1:266403632382:web:96106ed2c158f4747f81af',
            messagingSenderId: '266403632382',
            projectId: 'specialinstagram-788fb',
            storageBucket: 'specialinstagram-788fb.appspot.com'));
  } else {
    // android OR Ios
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Umniah Instagram',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      //ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout(),),
      home: Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  //autenticated user
                  return const ResponsiveLayout(
                    webScreenLayout: WebScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }
              return LoginScreen();
            }),
      ),
    );
  }
}
