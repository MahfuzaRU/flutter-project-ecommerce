import 'package:ecommerceapp/controllers/auth_controller.dart';
import 'package:ecommerceapp/controllers/order_controller.dart';
import 'package:ecommerceapp/core/widgets/error_text.dart';
import 'package:ecommerceapp/core/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;

    return ref.watch(getUserOrdersProvider(user.uid)).when(
        data: (orders) {
          if (orders.isEmpty) {
            return const ErrorText(text: 'No Orders Found');
          }
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                      ),
                      title: Row(
                        children: [
                          Text(
                            orders[index].name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 10),
                          Text("Status: ${orders[index].status}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          const Text(
                            'Order Date: ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(orders[index].createdAt),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      trailing: Text(
                        '\$${orders[index].total}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              });
        },
        error: (error, stackRace) => ErrorText(text: error.toString()),
        loading: () => const Loader());
  }
}
