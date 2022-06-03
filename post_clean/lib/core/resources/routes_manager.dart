import 'package:flutter/material.dart';
import 'package:post_clean/core/resources/strings_manager.dart';
import 'package:post_clean/features/posts/presentation/pages/posts_screen.dart';
import 'package:post_clean/main.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.splashRoute:
      //   return MaterialPageRoute(
      //       builder: (_) => MyHomePage(
      //             title: '',
      //           ));
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const PostsScreen());
      // case Routes.onBoardingRoute:
      //   return MaterialPageRoute(builder: (_) => const OnBoardingView());
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => const RegisterView());
      // case Routes.forgotPasswordRoute:
      //   return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      // case Routes.mainRoute:
      //   return MaterialPageRoute(builder: (_) => const MainView());
      // case Routes.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
