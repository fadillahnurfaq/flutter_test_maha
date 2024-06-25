import 'package:dartz/dartz.dart';
import 'package:flutter_test_maha/models/user_model.dart';
import 'package:flutter_test_maha/utils/http_service.dart';

import '../models/response_model.dart';

class UserService {
  Future<Either<String, ResponseModel<List<UserModel>>>> getAll() async {
    try {
      final response = await HttpService.request(endpoint: "users?page=2");
      return response.fold(
        (l) => Left(l),
        (r) => Right(
          ResponseModel.fromJson(
            r,
            (data) => (data as List<dynamic>)
                .map((item) => UserModel.fromJson(item))
                .toList(),
          ),
        ),
      );
    } catch (e) {
      return const Left(
          "Terjadi kesalahan pada aplikasi, silakan coba lagi nanti.");
    }
  }
}
