import 'package:chicken_house/APIV2/Screens/auth_screen.dart';
import 'package:chicken_house/main.dart';
import 'package:get/get.dart';

class RoutesClass {
  static String home = "/";
  static String getHomeRoute() => home;

  static String login = "/login";
  static String getloginRoute() => login;

  static List<GetPage> routes = [
    GetPage(page: () => const WelcomePage(), name: home),
    GetPage(page: () => const AuthScreen(), name: login),
  ];
}
