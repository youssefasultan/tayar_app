import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tayar_app/core/common/widgets/page_under_construction.dart';
import 'package:tayar_app/core/extentions/context_extention.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/string_constants.dart';
import 'package:tayar_app/src/authentication/data/models/user_model.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';
import 'package:tayar_app/src/authentication/presntation/view/sign_in_screen.dart';
import 'package:tayar_app/src/dashboard/presntation/view/dashboard_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();

      return _pageBuilder(
        (context) {
          final loggedUser = prefs.getString(loggedUserKey);

          if (prefs.getBool(logStatusKey) ?? true) {
            return AnimatedSplashScreen(
              splashTransition: SplashTransition.fadeTransition,
              duration: 3000,
              splash: 'assets/images/app_logo.png',
              splashIconSize: 200,
              backgroundColor: const Color(0xff191718),
              nextScreen: BlocProvider(
                create: (context) => sl<AuthBloc>(),
                child: const SignInScreen(),
              ),
            );
          } else if (loggedUser != null) {
            final user = UserModel.fromJson(loggedUser);

            context.userProvider.initUser(user);

            return AnimatedSplashScreen(
              splashTransition: SplashTransition.fadeTransition,
              duration: 3000,
              splash: 'assets/images/app_logo.png',
              splashIconSize: 200,
              backgroundColor: const Color(0xff191718),
              nextScreen: BlocProvider(
                create: (context) => sl<AuthBloc>(),
                child: const DashBoardScreen(),
              ),
            );
          }

          return AnimatedSplashScreen(
            splashTransition: SplashTransition.fadeTransition,
            duration: 3000,
            splash: 'assets/images/app_logo.png',
            splashIconSize: 200,
            backgroundColor: const Color(0xff191718),
            nextScreen: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const SignInScreen(),
            ),
          );
        },
        settings: settings,
      );

    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );

    case DashBoardScreen.routeName:
      return _pageBuilder(
        (_) => const DashBoardScreen(),
        settings: settings,
      );

    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, _, __) => page(context),
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
