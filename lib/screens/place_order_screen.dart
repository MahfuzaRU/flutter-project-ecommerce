import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/core/constants/constants.dart';
import 'package:ecommerceapp/core/themes/app_themes.dart';
import 'package:ecommerceapp/core/widgets/show_snackbar.dart';
import 'package:ecommerceapp/widgets/payment_gateway_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceNewOrderScreen extends ConsumerStatefulWidget {
  const PlaceNewOrderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlaceNewOrderScreenState();
}

class _PlaceNewOrderScreenState extends ConsumerState<PlaceNewOrderScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String? selected;

  void createOrder(WidgetRef ref) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        selected == null) {
      showSnackBar(context, "All fields are required");
      return;
    }
    final bdPhoneNumberRegex = RegExp(r'^01[3-9]\d{8}$');

    if (!bdPhoneNumberRegex.hasMatch(phoneController.text)) {
      showSnackBar(context, "Invalid Phone Number");
      return;
    }
    ref.read(orderControllerProvider.notifier).createOrder(
        context,
        ref,
        nameController.text.trim(),
        phoneController.text.trim(),
        addressController.text.trim(),
        selected!);
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider)!;
    nameController.text = user.name;
    emailController.text = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Place New Order'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  "Delivery Information",
                  style: AppTheme.mediumTextStyle,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: "Enter your name",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: "Enter your Email",
                      enabled: false),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    hintText: "Enter your Phone",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    hintText: "Enter your Address",
                  ),
                ),
                const SizedBox(height: 40),
                const Text("Select Payment Gateway",
                    style: AppTheme.mediumTextStyle),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (_, index) {
                    return PaymentMethodTile(
                      logo: Constants.gateways[index]['logo'],
                      name: Constants.gateways[index]['name'],
                      selected: selected ?? '',
                      onTap: () {
                        selected = Constants.gateways[index]['name']
                            .toString()
                            .replaceAll(' ', '_')
                            .toLowerCase();
                        setState(() {});
                      },
                    );
                  },
                  separatorBuilder: (_, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: Constants.gateways.length,
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () => createOrder(ref),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: selected == null
                            ? Colors.blueAccent.withOpacity(.5)
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: AppTheme.mediumTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
