import 'package:flutter/material.dart';

class PhoneVerifiedDashboard extends StatelessWidget {
  const PhoneVerifiedDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verified Dashboard'),
      ),
      body: Column(
        children: const [
          Text('This is Phone Verified Dashboard'),
        ],
      ),
    );
  }
}
