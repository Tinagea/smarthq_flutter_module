import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smarthq_flutter_module/constants/constants.dart';
import 'package:smarthq_flutter_module/cubits/cubits.dart';

import 'package:smarthq_flutter_module/utils/context_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';

class MainHome extends StatelessWidget {
  MainHome();

  @override
  Widget build(BuildContext context) {
    geaLog.debug("MainHome:build");
    return MultiRepositoryProvider(
      providers: AppRepositoryProviders.repositoryProviders,
      child: MultiBlocProvider(
          providers: AppBlocProviders.blocProviders,
          child: ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: Size(376, 812),
              builder: (context, child) {
                return FutureBuilder(
                    future: BlocProvider.of<NativeCubit>(context).getLanguagePreference(),
                    builder: (context, snapshot) {

                      if (snapshot.hasData) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: BuildEnvironment.showDebugModeBanner,
                          localizationsDelegates: [
                            AppLocalizations.delegate,
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                            GlobalCupertinoLocalizations.delegate,
                          ],
                          supportedLocales: [
                            const Locale('en', ''), // English, no country code
                            const Locale('es', ''), // Spanish, no country code
                            // ... other locales the app supports
                          ],
                          localeResolutionCallback: (locale, supportedLocales) {
                            // Check if the current device locale is supported
                            for (var supportedLocale in supportedLocales) {
                              var languageCode = snapshot.data as String;
                              if (languageCode.length >= 2) {
                                languageCode = languageCode.substring(0, 2);
                              }
                              if (languageCode == supportedLocale.languageCode) {
                                return supportedLocale;
                              }
                            }
                            // If the locale of the device is not supported, use the first one
                            // from the list (English, in this case).
                            return supportedLocales.first;
                          },
                          builder: (context, child) {
                            return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!);
                          },
                          onGenerateTitle: (context) {
                            ContextUtil.instance.setContext = context;
                            return 'Home';
                          },
                          theme: ThemeData(
                            appBarTheme: AppBarTheme(
                                color: Colors.black
                            ),
                          ),
                          initialRoute: '/',
                          routes: AppRoutes.routes,
                        );
                      }
                      else {
                        return Container();
                      }
                    }
                );
              }
          )
      ),
    );
  }
}
