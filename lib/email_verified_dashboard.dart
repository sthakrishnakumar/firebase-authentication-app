import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/features/auth/auth_service.dart';
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
        padding: const EdgeInsets.only(left: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.photoURL != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            if (user.photoURL == null)
              const CircleAvatar(
                child: Icon(Icons.person),
              ),
            const SizedBox(
              height: 20,
            ),
            // ignore: unnecessary_null_comparison
            Text(user != null ? 'Name: No name' : 'Name: ${user.displayName}'),
            const SizedBox(
              height: 20,
            ),
            // ignore: unnecessary_null_comparison
            Text(user != null
                ? 'PhotoUrl: No PhotoURL'
                : 'Photo Url: ${user.photoURL}'),
            const SizedBox(
              height: 20,
            ),
            // ignore: unnecessary_null_comparison
            Text(user != null ? 'Email: No Email' : 'Email: ${user.email}'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
