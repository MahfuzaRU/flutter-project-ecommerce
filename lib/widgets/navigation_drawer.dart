import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logout(BuildContext context, WidgetRef ref) {
    ref.read(authControllProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      child: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            backgroundImage: NetworkImage(user.profilePic),
          ),
          const SizedBox(height: 8),
          Text(user.name),
          const SizedBox(height: 8),
          const SizedBox(height: 20),
          ListTile(
            onTap: () => logout(context, ref),
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
          )
        ],
      )),
    );
  }
}
