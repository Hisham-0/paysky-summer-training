import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe_task/model/cart_model.dart';

class ProductsItems extends StatelessWidget {
  final String ID;
  final String name;
  final String description;
  final String image_url;
  final double price;
  void Function()? onPressed;

  ProductsItems({
    super.key,
    required this.ID,
    required this.name,
    required this.description,
    required this.image_url,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final quantity = cart.getQuantity(ID);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image and number of pieces
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 110,
                    child: Image.network(
                      image_url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_not_supported, size: 50);
                      },
                    ),
                  ),
                ),

                Column(
                  children: [
                    const Text("Pieces"),
                    MaterialButton(
                      onPressed: () => cart.increaseQuantity(ID),
                      child: const Icon(Icons.arrow_drop_up_sharp, size: 50.0),
                    ),
                    Text(quantity.toString()),
                    MaterialButton(
                      onPressed: () => cart.decreaseQuantity(ID),
                      child: const Icon(Icons.arrow_drop_down, size: 50.0),
                    ),
                  ],
                ),
              ],
            ),
            // item name
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              padding: const EdgeInsets.all(8.0),
              child: Text(name, style: const TextStyle(fontSize: 15.0)),
            ),

            SizedBox(height: 7.0),

            // price + add to cart
            Row(
              children: [
                Expanded(
                  child: Text(
                    "\$$price",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(12.0),
                  ),

                  child: MaterialButton(
                    onPressed: onPressed,
                    minWidth: 10.0,
                    child: const Text(
                      " Add to cart",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
