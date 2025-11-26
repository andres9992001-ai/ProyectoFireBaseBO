import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_firebase/auth_wrapper.dart';
import 'package:proyecto_firebase/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter final',

      theme: ThemeData(
        textTheme: GoogleFonts.vt323TextTheme(),
        scaffoldBackgroundColor: Color(ColorsBackGround().kGreyDark),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(ColorsLetters().kWhiteCream),
        ),
      ),
      home: AuthWrapper(),
    );
  }
}
