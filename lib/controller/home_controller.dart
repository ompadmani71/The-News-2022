import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:the_news/api/api.dart';
import 'package:the_news/model/news_model.dart';
import '../api/api_service.dart';
import '../enum/error_type.dart';
import 'base_controller.dart';

class HomeController extends BaseController {
  String apiKey = "134e85696523497f888229d1c1056a1d";

  RxInt selectedCategory = 0.obs;

  Rx<NewsModel> allNewsData = NewsModel().obs;
  Rx<NewsModel> businessNewsData = NewsModel().obs;
  Rx<NewsModel> entertainmentNewsData = NewsModel().obs;
  Rx<NewsModel> healthNewsData = NewsModel().obs;
  Rx<NewsModel> scienceNewsData = NewsModel().obs;
  Rx<NewsModel> sportNewsData = NewsModel().obs;
  Rx<NewsModel> tecNewsData = NewsModel().obs;

  Rx<NewsModel> newsCatData = NewsModel().obs;


  Future<void> getCategoryNews({String? category}) async {
    if (category == "All") {
      category = "";
    }
    try {
      showLoader();
      // categoryNewsData.close();
      await apiService.getRequest(
          queryParameters: {
            'country': 'id',
            'apiKey': apiKey,
            'category': category
          },
          url: ApiUrl.headline,
          onSuccess: (Map<String, dynamic> data) {
            dismissLoader();

            newsCatData.value = NewsModelFromJson(jsonEncode(data["response"]));
            newsCatData.refresh();

          /*  switch (selectedCategory.value) {
              case 0:
                allNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                allNewsData.refresh();
                break;

              case 1:
                businessNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                businessNewsData.refresh();
                break;
              case 2:
                entertainmentNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                entertainmentNewsData.refresh();
                break;
              case 3:
                healthNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                healthNewsData.refresh();
                break;

              case 4:
                scienceNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                scienceNewsData.refresh();
                break;
              case 5:
                sportNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                sportNewsData.refresh();
                break;

              case 6:
                tecNewsData.value =
                    NewsModelFromJson(jsonEncode(data["response"]));
                tecNewsData.refresh();
                break;
            }*/

            log("${allNewsData.value.totalResults}", name: "ca");
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
