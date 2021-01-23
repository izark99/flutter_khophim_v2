import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khophim/models/detail_model.dart';
import 'package:khophim/models/moviedb_model.dart';

class ResService {
  String apiKey = "4d4e4032d83cc5687487d5da7fd41907";
  Future<List<Results>> getData(int page) async {
    String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=vi-VN&page=$page";
    var response = await http.get(url);
    var parsed = json.decode(response.body);
    return (parsed['results'] as List).map((e) => Results.fromJson(e)).toList();
  }

  Future<DetailModel> getDetail(int movieID) async {
    String url =
        "https://api.themoviedb.org/3/movie/$movieID?api_key=$apiKey&language=vi-VN";
    var response = await http.get(url);
    var parsed = json.decode(response.body);
    return (DetailModel.fromJson(parsed));
  }
}
