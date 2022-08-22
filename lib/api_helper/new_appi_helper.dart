import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:the_news/api_helper/api.dart';
import 'package:the_news/model/news_model.dart';

class NewsApiHelper{

  NewsApiHelper._();
  static NewsApiHelper newsApiHelper = NewsApiHelper._();


  Future<NewsModel?> getCategoryNews({String? category}) async {
    if (category == "All") {
      category = "";
    }
    try {

      http.Response response = await http.get(Uri.parse("${ApiUrl.headline}?country=in&apiKey=${ApiUrl.apiKey}&category=$category"));

      // print('Method => GET , API URL ==> ${ApiUrl.headline}?country=in&apiKey=${ApiUrl.headline}&category= $category";
      print('Method => GET , API URL ==> ${ApiUrl.headline}?country=in&apiKey=${ApiUrl.apiKey}&category=$category');

      print("${response.statusCode}, ${response.body}");

      if(response.statusCode != 200){
      log("${response.statusCode}",error: "Status Code");
    }
    else{
      log(response.body,name: "Response");
      NewsModel newsData = NewsModelFromJson(response.body);
      print("newsData ${newsData.articles}");
      return newsData;

    }
    return null;

    }catch (e) {
      log("==>  $e",error: "ApiError");
    }
  }


}