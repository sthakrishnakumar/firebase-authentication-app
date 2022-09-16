import 'package:flutter/material.dart';

class FacebookVerifiedDashboard extends StatelessWidget {
  const FacebookVerifiedDashboard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facebook'),
      ),
      body: Column(
        children: const [
          Text('hello facebook'),
        ],
      ),
    );
  }
}
