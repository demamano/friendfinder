import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friendfinder/feature/auth/controller/auth_controller.dart';

import 'package:friendfinder/widgets/error.dart';
import 'package:friendfinder/widgets/labelpage.dart';
import 'package:friendfinder/widgets/loader.dart';

import 'feature/landing/screens/landing_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ThemeData(brightness: Brightness.light);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friend Finder',
      home: ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return const LandingPage();
            }
            return const Label();
          },
          error: (err, trace) {
            print(err.toString());
            return ErrorScreen(
              error: err.toString(),
            );
          },
          loading: () => const Loader()),
    );
  }
}
