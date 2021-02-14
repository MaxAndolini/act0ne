import 'package:act0ne/authentication_service.dart';
import 'package:act0ne/begin.dart';
import 'package:act0ne/sign_in.dart';
import 'package:act0ne/sign_up.dart';
import 'package:act0ne/splash.dart';
import 'package:act0ne/user/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
        routes: {
          '/begin': (_) => new Begin(),
          '/signIn': (_) => new SignIn(),
          '/signUp': (_) => new SignUp(),
          '/home': (_) => new Home(),
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
    bool successLogin = false;
    if (firebaseUser != null) successLogin = true;
    return Splash(login: successLogin);
  }
}
