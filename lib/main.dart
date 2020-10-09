import 'package:flutter/material.dart';
import 'package:movie_flutter/screen/login.dart';

import 'screen/home.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData.dark(),
        // home: Home(),
        home: Login(),
        debugShowCheckedModeBanner: false,
      ),
    );
