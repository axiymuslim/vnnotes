// ignore_for_file:  unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:vnnotes/constants/routes.dart';
import 'package:vnnotes/services/auth/authService.dart';
import 'package:vnnotes/views/notesview.dart';
import 'package:vnnotes/views/verify_email.dart';
import 'package:vnnotes/views/login_view.dart';
import 'package:vnnotes/views/register_view.dart';

import 'enums/menuAction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        loginRoute: (context) => LoginView(),
        registerRoute: (context) => RegisterView(),
        notesRoute: (context) => NotesView(),
        verifyEmailRoute: (context) => VerifyEmailView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return NotesView();
              } else {
                return VerifyEmailView();
              }
            } else {
              return LoginView();
            }
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
