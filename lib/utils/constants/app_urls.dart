class AppUrls {
  static const String BASE_URL = "http://10.0.2.2:5000/";

  static const Auth auth = Auth();
}

class Auth {
  const Auth();
  final String login = "search/login";
  final String register = "search/register";
  final String verifyOtp = "search/verify-otp";
}
