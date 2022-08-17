import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../enum/error_type.dart';

class ApiService {
  static final Dio _dio = Dio();


  Future<void> getRequest({
    required String url,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required Function(Map<String, dynamic>) onSuccess,
    required Function(ErrorType, String?) onError,
  }) async {
    try {
      print('Method => GET , API URL ==> $url');
      if (header != null) {
        _dio.options.headers.addAll(header);
      }
      var response = await _dio.get(url,queryParameters: queryParameters);
      log('response  ===>  $response');
      Map<String, dynamic> data = {};
      data["response"] = response.data;
      if (response.statusCode != 200) {
        onError(ErrorType.none, data["response"][0]["msg"]);
      } else {
        if(data["response"] is List){
          if (data["response"][0]["status"] != null) {
            if (data["response"][0]["status"] == false) {
              onError(ErrorType.none, data["response"][0]["msg"]);
              return;
            }
          }
        }else{
          if (data["response"]["status"] != null) {
            if (data["response"]["status"] == false) {
              onError(ErrorType.none, data["response"]["msg"]);
              return;
            }
          }
        }
        onSuccess(data);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        onError(ErrorType.internet, null);
      }
      if (e.response != null) {
        Map<String, dynamic> data = {};
        data["response"] = jsonDecode(e.response?.data);
        onError(ErrorType.none, data["response"][0]["msg"]);
      }
    }
    return;
  }

}

ApiService apiService = ApiService();
