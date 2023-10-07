import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_center/core/functions/navigator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              navigateReplacement(context, '/signIn');
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
    );
  }
}
