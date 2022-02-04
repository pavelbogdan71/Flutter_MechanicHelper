import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mechanic_helper/authentication_service.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("HOME"),
            ElevatedButton(
                onPressed: (){
                  context.read<AuthenticationService>().signOut();
                },
              child: Text("Sign out"),
            )
          ],
        )
      ),
    );
  }
}