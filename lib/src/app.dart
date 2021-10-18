import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:up_the_shelf/src/ui/auth/sign_in_screen.dart';
import 'package:up_the_shelf/src/ui/home/home_screen.dart';
import 'package:up_the_shelf/src/utils/models/user_model.dart';
import 'package:up_the_shelf/src/utils/providers/auth_provider.dart';
import 'package:up_the_shelf/src/utils/providers/language_provider.dart';
import 'package:up_the_shelf/src/utils/providers/theme_provider.dart';
import 'package:up_the_shelf/src/utils/services/firestore_database.dart';
import 'package:up_the_shelf/src/widgets/auth_widget_builder.dart';

import 'config/app_theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({required Key key, required this.databaseBuilder})
      : super(key: key);

  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        //{context, data, child}
        return Consumer<LanguageProvider>(
          builder: (_, languageProviderRef, __) {
            return AuthWidgetBuilder(
              databaseBuilder: databaseBuilder,
              builder: (BuildContext context,
                  AsyncSnapshot<UserModel?> userSnapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // Providing a restorationScopeId allows the Navigator built by the
                  // MaterialApp to restore the navigation stack when a user leaves and
                  // returns to the app after it has been killed while running in the
                  // background.
                  restorationScopeId: 'UpTheShelfApp',

                  // Provide the generated AppLocalizations to the MaterialApp. This
                  // allows descendant Widgets to display the correct translations
                  // depending on the user's locale.
                  locale: languageProviderRef.appLocale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', ''), // English, no country code
                  ],
                  //return a locale which will be used by the app
                  localeResolutionCallback: (locale, supportedLocales) {
                    //check if the current device locale is supported or not
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode ==
                              locale?.languageCode ||
                          supportedLocale.countryCode == locale?.countryCode) {
                        return supportedLocale;
                      }
                    }
                    //if the locale from the mobile device is not supported yet,
                    //user the first one from the list (in our case, that will be English)
                    return supportedLocales.first;
                  },

                  // Use AppLocalizations to configure the correct application title
                  // depending on the user's locale.
                  //
                  // The appTitle is defined in .arb files found in the localization
                  // directory.
                  onGenerateTitle: (BuildContext context) =>
                      AppLocalizations.of(context)!.appTitle,

                  // Define a light and dark color theme. Then, read the user's
                  // preferred ThemeMode (light, dark, or system default) from the
                  // themeProviderRef to display the correct theme.
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  // themeMode: themeProviderRef.isDarkModeOn ||
                  //         (SchedulerBinding
                  //                 .instance!.window.platformBrightness ==
                  //             Brightness.dark)
                  //     ? ThemeMode.dark
                  //     : ThemeMode.light,
                  themeMode: ThemeMode.system,
                  builder: (context, widget) => ResponsiveWrapper.builder(
                      widget,
                      maxWidth: 750,
                      minWidth: 450,
                      defaultScale: true,
                      breakpoints: [
                        const ResponsiveBreakpoint.resize(450, name: MOBILE),
                        const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                        const ResponsiveBreakpoint.autoScale(1000,
                            name: TABLET),
                        const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                        const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
                      ],
                      background: Container(
                          color: ThemeMode.system == ThemeMode.light
                              ? AppTheme.lightBG
                              : AppTheme.darkBG)),

                  home: Consumer<AuthProvider>(
                    builder: (_, authProviderRef, __) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.active) {
                        return userSnapshot.hasData
                            ? const HomeScreen()
                            : const SignInScreen();
                      }

                      return const Material(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
                );
              },
              key: const Key('AuthWidget'),
            );
          },
        );
      },
    );
  }
}
