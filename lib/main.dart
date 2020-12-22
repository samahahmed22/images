import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/home_screen.dart';
import './screens/splash_screen.dart';
import './providers/auth.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, appSnapshot) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (ctx) => Auth()),
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flicker images',
                  theme: ThemeData(
                    primaryColor: Colors.blue,
                  ),
                  home: appSnapshot.connectionState != ConnectionState.done
                      ? SplashScreen()
                      : StreamBuilder(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (ctx, userSnapshot) {
                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SplashScreen();
                            }
                            if (userSnapshot.hasData) {
                              return HomeScreen();
                            }
                            return LoginScreen();
                          }),
                
              ));
        });
  }
}
