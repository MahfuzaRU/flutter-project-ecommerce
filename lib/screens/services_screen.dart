import 'package:ecommerceapp/core/themes/app_themes.dart';
import 'package:ecommerceapp/core/themes/colours.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Select Service',
                style: AppTheme.mediumTextStyle,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gradient1),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).push('/place-order');
                  },
                  child: const Text('Self-Pick-up'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gradient1),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).push('/place-order');
                  },
                  child: const Text('Order'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gradient1),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).push('/place-order');
                  },
                  child: const Text('Order-on-preferred time'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.gradient1),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
