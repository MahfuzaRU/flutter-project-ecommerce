import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/core/themes/colours.dart';
import 'package:ecommerceapp/core/widgets/error_text.dart';
import 'package:ecommerceapp/core/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ref.watch(getCatagoriesProvider).when(
          //     data: (data) {
          //       return SingleChildScrollView(
          //         scrollDirection: Axis.horizontal,
          //         child: Row(
          //           children: data
          //               .map((e) => buildCatagoryItem(context, e.name))
          //               .toList(),
          //         ),
          //       );
          //     },
          //     error: (e, s) => ErrorText(text: e.toString()),
          //     loading: () => const Loader()),

          const Text(
            "Products",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          ref.watch(getAllProductsProvider).when(
              data: (data) {
                return Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 140,
                                child: Image.network(data[index].image),
                              ),
                              Text(
                                data[index].name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text('${data[index].price} TK.'),
                            ],
                          ),
                        );
                      }),
                );
              },
              error: (e, s) => ErrorText(text: e.toString()),
              loading: () => const Loader())
        ],
      ),
    );
  }

  Widget buildCatagoryItem(BuildContext context, String name) {
    return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Chip(
              color: const WidgetStatePropertyAll(AppColors.gradient3),
              label: Text(name)),
        ));
  }
}
