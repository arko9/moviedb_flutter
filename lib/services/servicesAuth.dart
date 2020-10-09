import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_flutter/models/index.dart';
import 'package:movie_flutter/network/network.dart';

class ServicesAuth {
  static Future<User> cekEmail(String email) async {
    Dio dio = Dio();
    FormData maps = FormData.fromMap({
      "email": email,
    });
    final response = await dio.post(
      NetworkURL.cekEmail(),
      data: maps,
    );
    // print("JSON FORMAT : ${response.data}");
    final data = jsonDecode(response.data);
    // print("JSON OBJECT : $data");
    User user = User.fromJson(data);
    return user;
  }

  static Future<User> registrasi(
    String email,
    String namaLengkap,
    String phone,
    String photo,
  ) async {
    Dio dio = Dio();
    FormData maps = FormData.fromMap({
      "email": email,
      "namaLengkap": namaLengkap,
      "phone": phone,
      "photo": photo,
    });
    final response = await dio.post(
      NetworkURL.registrasi(),
      data: maps,
    );
    final data = jsonDecode(response.data);
    // print("JSON OBJECT : $data");
    User user = User.fromJson(data);
    return user;
  }
}
