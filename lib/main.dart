import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:up_the_shelf/src/utils/providers/auth_provider.dart';
import 'package:up_the_shelf/src/utils/providers/language_provider.dart';
import 'package:up_the_shelf/src/utils/providers/theme_provider.dart';
import 'package:up_the_shelf/src/utils/services/firestore_database.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: MyApp(
        databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        key: const Key('UpTheShelfApp'),
      ),
    ),
  );
}
