import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:the_news/api_helper/api.dart';
import 'package:the_news/model/news_model.dart';

class NewsApiHelper{

  NewsApiHelper._();
  static NewsApiHelper newsApiHelper = NewsApiHelper._();
  

}