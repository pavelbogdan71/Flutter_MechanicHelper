import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_helper/authentication_service.dart';
import 'package:provider/src/provider.dart';

class Body extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("profile"),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text("Sign out"),
              )
            ]),
      ),
    );
  }
}