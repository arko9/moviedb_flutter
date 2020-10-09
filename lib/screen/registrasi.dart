import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_flutter/screen/login.dart';
import 'package:movie_flutter/services/servicesAuth.dart';

class Registrasi extends StatefulWidget {
  final User user;

  const Registrasi({Key key, this.user}) : super(key: key);

  @override
  _RegistrasiState createState() => _RegistrasiState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _RegistrasiState extends State<Registrasi> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  void cek() {
    if (_key.currentState.validate()) {
      simpan();
    }
  }

  simpan() {
    // print(
    //   "Nama ${namaController.text}",
    // );

    ServicesAuth.registrasi(
      emailController.text,
      namaController.text,
      phoneController.text,
      widget.user.photoURL,
    ).then((value) {
      if (value.value == 1) {
        print("${value.message}");
      } else {
        print("${value.message}");
      }
    });
  }

  @override
  void initState() {
    namaController = TextEditingController(text: "${widget.user.displayName}");
    emailController = TextEditingController(text: "${widget.user.email}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              await GoogleSignIn().signOut();
              await _auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
            }),
        title: Text("Registrasi Users"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "This field is requried";
                } else {
                  return null;
                }
              },
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
              ),
            ),
            TextField(
              enabled: false,
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextFormField(
              validator: (e) {
                if (e.isEmpty) {
                  return "This field is requried";
                } else {
                  return null;
                }
              },
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              // onTap: () => signinGoogle(),
              // onTap: signinGoogle,
              onTap: () {
                cek();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Sign Up Now",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
