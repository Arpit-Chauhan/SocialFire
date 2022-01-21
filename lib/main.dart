import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialfire/providers/user_provider.dart';
import 'package:socialfire/responsive/mobile_screen_layout.dart';
import 'package:socialfire/responsive/responsive_layout_screen.dart';
import 'package:socialfire/responsive/web_screen_layout.dart';
import 'package:socialfire/screens/login_screen.dart';
import 'package:socialfire/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for initializing firebase for web and apps differently
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBSwPfdOZCl5zmrsACrQeXQChOFIBT7Yrc',
        appId: '1:590027780542:web:a66f545b3b027a3bd149ef',
        messagingSenderId: '590027780542',
        projectId: 'socialfire-a40b3',
        storageBucket: "socialfire-a40b3.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SocialFire',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home:
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error}',
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return LoginScreen();
          },
        ),
      ),
    );
  }
}
