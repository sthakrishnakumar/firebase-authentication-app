import 'package:flutter/material.dart';

class PhoneVerifiedDashboard extends StatelessWidget {
  const PhoneVerifiedDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verified Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Phone Verified'),
          ],
        ),
      ),
    );
  }
}
