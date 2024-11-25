import 'package:ecommerceapp/controllers/catagory_controller.dart';
import 'package:ecommerceapp/controllers/product_controller.dart';
import 'package:ecommerceapp/core/themes/colours.dart';
import 'package:ecommerceapp/core/widgets/error_text.dart';
import 'package:ecommerceapp/core/widgets/loader.dart';
import 'package:ecommerceapp/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  String? selectedCatagory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ref.watch(getCatagoriesProvider).when(
              data: (data) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCatagory = null;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Chip(
                                color:
                                    WidgetStatePropertyAll(AppColors.gradient3),
                                label: Text("All")),
                          )),
                      ...data.map((e) => buildCatagoryItem(context, e.name))
                    ],
                  ),
                );
              },
              error: (e, s) => ErrorText(text: e.toString()),
              loading: () => const Loader()),
          const Text(
            "Products",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),
          if (selectedCatagory != null)
            ref.watch(getProductByCatagoryProvider(selectedCatagory!)).when(
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
                          return ProductCard(product: data[index]);
                        }),
                  );
                },
                error: (e, s) => ErrorText(text: e.toString()),
                loading: () => const Loader()),
          if (selectedCatagory == null)
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
                          return ProductCard(product: data[index]);
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
        onTap: () {
          setState(() {
            selectedCatagory = name;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Chip(
              color: const WidgetStatePropertyAll(AppColors.gradient3),
              label: Text(name)),
        ));
  }
}
