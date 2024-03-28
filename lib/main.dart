import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/app/providers/orders_provider.dart';
import 'package:tayar_app/core/common/app/providers/report_provider.dart';
import 'package:tayar_app/core/common/app/providers/user_provider.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/services/router.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';

import 'package:tayar_app/src/dashboard/presntation/providers/dashboard_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  GoogleFonts.config.allowRuntimeFetching = false;

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FlutterLocalization _localization = FlutterLocalization.instance;

  @override
  void initState() {
    _localization
      ..init(
        mapLocales: [
          MapLocale(
            'en',
            AppLocale.EN,
            fontFamily: GoogleFonts.notoSerif().fontFamily,
          ),
          MapLocale(
            'ar',
            AppLocale.AR,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ],
        initLanguageCode: 'ar',
      )
      ..onTranslatedLanguage = _onTranslatedLanguage;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(loginImgPath), context);
    precacheImage(const AssetImage(bannerImgPath), context);
    super.didChangeDependencies();
  }

  void _onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => DashboardController(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrdersProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ReportProvider(),
            ),
          ],
          child: MaterialApp(
            supportedLocales: _localization.supportedLocales,
            localizationsDelegates: _localization.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            locale: _localization.currentLocale,
            onGenerateRoute: generateRoute,
          ),
        );
      },
    );
  }
}
