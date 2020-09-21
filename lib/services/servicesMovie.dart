import 'dart:convert';

import 'package:http/http.dart' as abc;

import 'package:movie_flutter/models/movie.dart';
import 'package:movie_flutter/network/network.dart';

class ServicesMovie {
  static Future<List<Movie>> getNowPlaying() async {
    final response = await abc.get(NetworkURL.urlNowPlaying);
    final data = jsonDecode(response.body)['results'];
    List<Movie> list = [];
    for (Map i in data) {
      list.add(Movie.fromJson(i));
    }
    return list;
  }
}
