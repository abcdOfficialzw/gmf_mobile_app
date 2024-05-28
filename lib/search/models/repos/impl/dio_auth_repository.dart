import 'package:dio/dio.dart';

import '../../../../models/networking_response.dart';
import '../../../../services/networking_service.dart';
import '../abs/auth_repository.dart';

class DioAuthRepository implements AuthRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
  ));

  Future<void> authenticate(String phoneNumber, String otp) async {
    try {} on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<NetworkingResponse> requestOTP(String phoneNumber) async {
    NetworkingResponse response;
    try {
      return await NetworkingService().makeHttpCall(
          method: 'POST',
          url: '/requestOTP',
          body: {'phoneNumber': phoneNumber}).then((value) {
        response = value;
        return response;
      });
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> resendOTP(String phoneNumber) async {
    try {
      await _dio.post('/resendOTP', data: {'phoneNumber': phoneNumber});
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
