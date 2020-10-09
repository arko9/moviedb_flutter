import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_flutter/screen/home.dart';
import 'package:movie_flutter/screen/registrasi.dart';
import 'package:movie_flutter/services/servicesAuth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginState extends State<Login> {
  void signinGoogle() async {
    UserCredential userCredential;
    final GoogleSignInAccount googleUsers = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUsers.authentication;
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    userCredential = await _auth.signInWithCredential(googleAuthCredential);
    final user = userCredential.user;
    if (user != null) {
      ServicesAuth.cekEmail(user.email).then((u) {
        if (u.value == 0) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Registrasi(
                  user: user,
                ),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(
                        user: u,
                      )));
        }
        // print("value ${u.value}");
        // print("message ${u.message}");
      });
      // ServicesAuth.cekEmail(user.email);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Home(
      //               user: user,
      //             )));
    }
    // print(user);
    print(user.email);
    print(user.displayName);
    print(user.photoURL);
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          // onTap: () => signinGoogle(),
          // onTap: signinGoogle,
          onTap: () {
            signinGoogle();
          },
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 100),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text("Sign In With Google"),
          ),
        ),
      ),
    );
  }
}
