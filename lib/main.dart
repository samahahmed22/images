import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/image_details_screen.dart';
import 'screens/search_result_screen.dart';
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
        textTheme: Theme.of(context).textTheme.copyWith(
              headline1: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              headline2: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
              headline3: TextStyle(
                  color: Colors.black45,
                  fontStyle: FontStyle.italic,
                  fontSize: 16),
            ),
      ),
      home: _showScreen(context),
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          "search": (ctx) => SearchResultScreen(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      routes: {
        ImageDetailsScreen.routeName: (ctx) => ImageDetailsScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        // SearchResultScreen.routeName: (ctx) => SearchResultScreen(),
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
