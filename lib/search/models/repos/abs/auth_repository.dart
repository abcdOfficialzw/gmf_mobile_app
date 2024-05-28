import '../../../../models/networking_response.dart';

abstract class AuthRepository {
  Future<void> authenticate(String phoneNumber, String otp);
  Future<NetworkingResponse> requestOTP(String phoneNumber);
  Future<void> resendOTP(String phoneNumber);
}
