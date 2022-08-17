import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:the_news/api/api.dart';
import 'package:the_news/model/news_model.dart';
import '../api/api_service.dart';
import '../enum/error_type.dart';
import 'base_controller.dart';

class HomeController extends BaseController{

  String apiKey = "134e85696523497f888229d1c1056a1d";

  RxInt selectedCategory = 0.obs;

  Rx<NewsModel>  categoryNewsData = NewsModel().obs;

  Dio _dio = Dio();

  Future<void> getCategoryNews() async {
    try {
      showLoader();
      await apiService.getRequest(
        url: "${ApiUrl.headline}?country=id&apiKey=$apiKey&category=Health",
          onSuccess: (Map<String, dynamic> data) {
            dismissLoader();

            categoryNewsData.value = NewsModelFromJson(jsonEncode(data["response"]));
            categoryNewsData.refresh();

            log("${categoryNewsData.value.totalResults}",name: "ca");

          },
          onError: (ErrorType errorType, String? msg) {
            showError(msg: msg);
          });
      // var response =  await _dio.get(
      //   "${ApiUrl.headline}?country=id&apiKey=$apiKey&category=Health",
      // );
      //
      // print("Status Code ${response.statusCode}");
    } catch (e) {
      showError(msg: "$e");
      log("message   ==>  $e");
    }
  }


}
