import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerifiedDashboard extends StatelessWidget {
  const EmailVerifiedDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is Dashboard Page'),
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            Text('Name: ${user.displayName}'),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
