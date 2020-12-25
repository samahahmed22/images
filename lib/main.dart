import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/image_details_screen.dart';
import 'screens/search_screen.dart';
import './screens/splash_screen.dart';
import './providers/auth.dart';
import 'providers/images.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(create: (context) => Images()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flickr images',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: _showScreen(context),
      routes: {
        ImageDetailsScreen.routeName: (ctx) => ImageDetailsScreen(),
      },
    );
  }

  Widget _showScreen(context) {
    var provider = Provider.of<Auth>(context);
    switch (provider.authStatus) {
      case AuthStatus.authentecating:
        return SplashScreen();
      case AuthStatus.unAuthenticated:
        return LoginScreen();
      case AuthStatus.authenticated:
        return SearchScreen();
    }
    return Container();
  }
}
