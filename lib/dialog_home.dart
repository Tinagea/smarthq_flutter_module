import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smarthq_flutter_module/constants/constants.dart';
import 'package:smarthq_flutter_module/cubits/dialog/dialog_cubit.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smarthq_flutter_module/localization/localization.dart';
import 'package:smarthq_flutter_module/utils/log_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smarthq_flutter_module/environment/build_environment.dart';
import 'package:smarthq_flutter_module/view/common/constant/routes.dart';

final RouteObserver<PageRoute> dialogRouteObserver = RouteObserver<PageRoute>();

class DialogHome extends StatelessWidget {
  DialogHome();

  @override
  Widget build(BuildContext context) {
    geaLog.debug("DialogHome:build");
    return MultiRepositoryProvider(
      providers: AppRepositoryProviders.repositoryProvidersForDialog,
      child: MultiBlocProvider(
          providers: AppBlocProviders.blocProvidersForDialog,
          child: ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: Size(376, 812),
              builder: (context, child) {
                return FutureBuilder(
                    future: BlocProvider.of<DialogCubit>(context).getLanguagePreference(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var languageCode = snapshot.data as String;
                        languageCode = (languageCode.length >= 2)
                            ? languageCode.substring(0, 2) : 'en';
                        return MaterialApp(
                          debugShowCheckedModeBanner: BuildEnvironment.showDebugModeBanner,
                          navigatorObservers: [dialogRouteObserver],
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
                          theme: ThemeData(
                            appBarTheme: AppBarTheme(
                                color: Colors.black
                            ),
                          ),
                          initialRoute: Routes.DIALOG_ROOT_BACKGROUND,
                          onGenerateRoute: AppRoutes.generateRouteForDialog,
                          routes: AppRoutes.routesForDialog,
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