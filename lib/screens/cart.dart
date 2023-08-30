import 'package:flutter/material.dart';
import 'package:nout_shop_app/screens/home.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.stream,
      initialData: controller.state,
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: Text("Total: ${controller.state.total.toStringAsFixed(2)}"),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.state.items.length,
          itemBuilder: (context, index) {
            final item = controller.state.items[index];

            return Card(
              child: ListTile(
                leading: SizedBox(
                  width: 80,
                  child: Stack(
                    children: [
                      Image(
                        image: NetworkImage(item.product.imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: 25,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            item.quantity.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                title: Text(
                  item.product.name,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(item.product.description),
                        ),
                        const SizedBox(width: 10),
                        Text(item.product.price.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total: ${item.total.toStringAsFixed(2)}"),
                        IconButton.filled(
                          onPressed: () => controller.addToCard(
                              product: item.product, quantity: 1),
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        IconButton.filled(
                          onPressed: () => controller.addToCard(
                              product: item.product, quantity: -1),
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.payment_rounded),
        ),
      ),
    );
  }
}
