import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_news/model/news_model.dart';
import '../api_helper/api.dart';

class NewsController extends GetxController {
  final Dio _dio = Dio();

  RxSet<int> randomNumber = <int>{}.obs;
  math.Random random = math.Random();

  RxList<Article> topHeadLineNews = <Article>[].obs;
  RxList<Article> headLineNews = <Article>[].obs;

  RxList<Article> categoryNews = <Article>[].obs;

  Future<void> getHeadline() async {
    try {
      var response = await _dio
          .get("${ApiUrl.headline}?country=in&apiKey=${ApiUrl.apiKey}");

      // print('Method => GET , API URL ==> ${ApiUrl.headline}?country=in&apiKey=${ApiUrl.headline}&category= $category";
      print(
          'Method => GET , API URL ==> ${ApiUrl.headline}?country=in&apiKey=${ApiUrl.apiKey}&category=');

      if (response.statusCode != 200) {
        log("${response.statusCode}", error: "Status Code");
      } else {
        News data = NewsFromJson(jsonEncode(response.data));

        for (int i = 0; randomNumber.length != 5; i++) {
          int ran = random.nextInt(data.articles.length);
          randomNumber.add(ran);
        }

        headLineNews.clear();

        for (int i = 0; i < randomNumber.length; i++) {
          headLineNews.add(data.articles[i]);
        }

        print(
            "0w9idu8hjkop ==> ${topHeadLineNews.length} ${headLineNews.length}");

        update();
        print("object ==> ${headLineNews.length}");
      }
    } on DioError catch (e) {
      log("$e", name: "Dio Error");
    } catch (e) {
      log("ERROR: $e");
    }
  }

  Future<void> getCategoryNews({required String category}) async {
    try {
      String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

      var response = await _dio.get(
          "${ApiUrl.category}?q=$category&from=$today&sortBy=popularity&apiKey=${ApiUrl.apiKey}");

      if (response.statusCode != 200) {
        log("${response.statusCode}", error: "Status Code");
      } else {
        News data = NewsFromJson(jsonEncode(response.data));

        categoryNews.value = data.articles;
        update();
        print("object ==> ${headLineNews.length}");
      }
    } on DioError catch (e) {
      log("$e", name: "Dio Error");
    } catch (e) {
      log("ERROR: $e");
    }
  }
}
