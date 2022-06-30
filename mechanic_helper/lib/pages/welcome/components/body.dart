import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mechanic_helper/pages/login/login_screen.dart';
import 'package:mechanic_helper/pages/signup/signup_screen.dart';
import 'package:mechanic_helper/pages/welcome/components/background.dart';
import 'package:mechanic_helper/components/rounded_button.dart';
import 'package:mechanic_helper/constants/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO MECHANIC HELPER",
              style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.w900,
                fontSize: 17
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/welcome_image.jpg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                ),
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.white24,
              textColor: Colors.black,
              press: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
