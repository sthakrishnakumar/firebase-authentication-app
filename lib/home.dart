import 'package:firebase_auth_app/commons/commons.dart';
import 'package:firebase_auth_app/features/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'features/phone_auth/presentation/screens/mobile_add_page.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                navigation(
                  context,
                  const MobileAddPage(),
                );
              },
              child: const Text('Phone Verification'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              onPressed: () {
                // final provider =
                //     Provider.of<GoogleSignInProvider>(context, listen: false);
                // provider.googleLogin();

                AuthService().signInWithGoogle();
              },
              label: const Text('Login with Google'),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
