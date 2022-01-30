import 'package:flutter/material.dart';
import 'package:softagi/shared/components/network/styles/theme.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Signup',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
