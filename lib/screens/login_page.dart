import 'package:flutter/material.dart';
import 'package:least_app/screens/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = "login";

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);
    if (vm.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text("Least"),
                Spacer(),
                Column(
                  children: [
                    ElevatedButton(
                      child: Text("Googleでログイン"),
                      onPressed: () async => await vm.loginFlowWithGoogle(),
                    ),
                    ElevatedButton(
                      child: Text("Appleでログイン"),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
