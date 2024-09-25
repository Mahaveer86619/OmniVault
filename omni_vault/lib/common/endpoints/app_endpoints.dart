import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndpoints {
  static String baseUrl = dotenv.get('BASE_URL');

  static String test = '$baseUrl/';

  static String loginUrl = '$baseUrl/auth/login';
  static String registerUrl = '$baseUrl/auth/register';
}