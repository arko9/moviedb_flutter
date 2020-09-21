import 'package:flutter/material.dart';

import 'screen/home.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
