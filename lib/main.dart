// ignore_for_file: unnecessary_null_comparison

import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/core/themes/app_themes.dart';
import 'package:ecommerceapp/core/widgets/error_text.dart';
import 'package:ecommerceapp/core/widgets/loader.dart';
import 'package:ecommerceapp/firebase_options.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:ecommerceapp/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? user;

  void getUserData(WidgetRef ref, User data) async {
    user = await ref
        .watch(authControllProvider.notifier)
        .getUserData(data.uid)
        .first;

    ref.read(userProvider.notifier).update((state) => user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangesProvider).when(
        data: (data) {
          getUserData(ref, data!);
          return MaterialApp.router(
            title: "Ecommerce App",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.darkThemeMode,
            routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
              if (data != null) {
                return loggedInRoute;
              }
              return loggedOutRoute;
            }),
            routeInformationParser: const RoutemasterParser(),
          );
        },
        error: (e, s) => ErrorText(text: e.toString()),
        loading: () => const Loader());
  }
}
