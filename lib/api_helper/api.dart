import 'dart:io';

class ApiUrl {

  static const String _baseUrl = "https://newsapi.org";

  static const String headline = "$_baseUrl/v2/top-headlines";
  static const String category = "$_baseUrl/v2/everything";

  static const String apiKey = "134e85696523497f888229d1c1056a1d";

}
