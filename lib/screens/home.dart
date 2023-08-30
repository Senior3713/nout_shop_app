import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nout_shop_app/controller/cart_cubit.dart';
import 'package:nout_shop_app/controller/cart_model.dart';
import 'package:nout_shop_app/screens/cart.dart';

final controller = CartCubit();

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOUT Shop"),
        centerTitle: true,
        actions: [
          StreamBuilder(
            builder: (context, snapshot) => Badge(
              alignment: const Alignment(0.8, -0.8),
              label: Text(controller.state.items.length.toString()),
              child: IconButton.filled(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                icon: const Icon(
                  CupertinoIcons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
            stream: controller.stream,
            initialData: controller.state,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.6,
        children: products.map((product) {
          return DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Text(
                                  product.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 2,
                                )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "${product.price}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )),
                          ],
                        ),
                        StreamBuilder(
                          builder: (context, snapshot) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton.filled(
                                onPressed: () => controller.addToCard(product: product, quantity: 1),
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton.filled(
                                onPressed: () => controller.addToCard(product: product, quantity: -1),
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          stream: controller.stream,
                          initialData: controller.state,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
