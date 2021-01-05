import 'package:act0ne/authentication_service.dart';
import 'package:act0ne/begin.dart';
import 'package:act0ne/home.dart';
import 'package:act0ne/signin.dart';
import 'package:act0ne/signup.dart';
import 'package:act0ne/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'MainF',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
        routes: {
          "/begin": (_) => new Begin(),
          "/signin": (_) => new SignIn(),
          "/signup": (_) => new SignUp(),
          "/home": (_) => new Home(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return Begin();
    }
    return Splash();
  }
}
