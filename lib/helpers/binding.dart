import 'package:get/get.dart';
import 'package:khophim/controllers/account_controller.dart';
import 'package:khophim/controllers/animated_movies_controller.dart';
import 'package:khophim/controllers/auth_controller.dart';
import 'package:khophim/controllers/history_controller.dart';
import 'package:khophim/controllers/home_controller.dart';
import 'package:khophim/controllers/movie_controller.dart';
import 'package:khophim/controllers/recommend_controller.dart';
import 'package:khophim/controllers/search_controller.dart';
import 'package:khophim/controllers/theater_movies_controller.dart';
import 'package:khophim/controllers/tv_series_controller.dart';
import 'package:khophim/controllers/tv_shows_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => RecommendController());
    Get.lazyPut(() => TVSeriesController());
    Get.lazyPut(() => TheaterMoviesController());
    Get.lazyPut(() => AnimatedMoviesController());
    Get.lazyPut(() => TVShowsController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => MovieController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => HistoryController());
  }
}
