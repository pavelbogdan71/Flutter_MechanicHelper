import 'package:flutter/material.dart';
import 'package:mechanic_helper/pages/services/authentication_service.dart';
import 'package:mechanic_helper/pages/login/login_screen.dart';
import 'package:mechanic_helper/pages/signup/components/background.dart';
import 'package:mechanic_helper/pages/signup/components/or_divider.dart';
import 'package:mechanic_helper/pages/signup/components/social_icon.dart';
import 'package:mechanic_helper/components/already_have_an_account_acheck.dart';
import 'package:mechanic_helper/components/rounded_button.dart';
import 'package:mechanic_helper/components/rounded_input_field.dart';
import 'package:mechanic_helper/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';


class Body extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Form(
              key: _formkey,
              child:Column(
                children:[
                RoundedInputField(
                  controller: emailController,
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  onChanged: (value) {},
                ),
                  RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      context.read<AuthenticationService>().signUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()
                      );
                      FormState? form = _formkey.currentState;
                      form?.validate();
                    },
                  ),
                ]
              )
            ),

            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
