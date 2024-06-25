import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test_maha/utils/app_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dartz/dartz.dart';

enum MethodRequest { get, post, download }

class HttpService {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));

  static Future<Either<String, dynamic>> request({
    String endpoint = "",
    MethodRequest method = MethodRequest.get,
    dynamic data,
    Map<String, String>? headers,
    String url = "",
    String savePath = "",
  }) async {
    try {
      final Map<String, String> fixHeaders = {
        HttpHeaders.contentTypeHeader: "application/json"
      };
      dynamic responseData;
      final response = method == MethodRequest.get
          ? await _dio.get(
              "${AppApi.baseUrl}/$endpoint",
              options: Options(headers: headers ?? fixHeaders),
            )
          : method == MethodRequest.download
              ? await _dio.download(url, savePath)
              : await _dio.post(
                  "${AppApi.baseUrl}/$endpoint",
                  data: data,
                  options: Options(headers: headers ?? fixHeaders),
                );
      if (method == MethodRequest.download) {
        responseData = response.data;
      } else {
        responseData = response.data;
      }
      return right(responseData);
    } on DioException catch (e) {
      return left(_fromDioError(e));
    }
  }

  static String _fromDioError(DioException e) {
    if (e.error is SocketException) {
      return "Anda tidak terhubung ke jaringan.";
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "Koneksi ke server kehabisan waktu.";

      case DioExceptionType.sendTimeout:
        return "Waktu mengirim ke server kehabisan waktu.";

      case DioExceptionType.receiveTimeout:
        return "Waktu menerima data dari server kehabisan waktu.";

      case DioExceptionType.badResponse:
        return "Kesalahan internal server, silakan coba lagi";
      case DioExceptionType.cancel:
        return "Permintaan ke server dibatalkan.";

      case DioExceptionType.unknown:
        return "Kesalahan yang tidak terduga, Silakan coba lagi.";

      default:
        return "Kesalahan yang tidak terduga, Silakan coba lagi.";
    }
  }
}
