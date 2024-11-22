import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/core/constants/constants.dart';
import 'package:ecommerceapp/core/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welocome to Ecomm',
              style: AppTheme.bigTextStyle,
            ),
            const SizedBox(height: 10),
            const Text(
              'Sign In',
              style: AppTheme.mediumTextStyle,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () => signInWithGoogle(ref, context),
                icon: Image.asset(
                  Constants.googlePath,
                  height: 40,
                ),
                label: const Text(
                  'Continue with Google',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey, width: 1.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.transparent),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signInWithGoogle(WidgetRef ref, BuildContext context) {
    ref.read(authControllProvider.notifier).signInWithGoogle(context);
  }
}
