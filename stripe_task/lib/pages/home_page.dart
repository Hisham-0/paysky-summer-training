import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:DemoShop/components/products_items.dart';
import 'package:DemoShop/model/cart_model.dart';
import 'package:DemoShop/pages/cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<CartModel>(
        builder: (context, value, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CartPage();
                    },
                  ),
                ),
              ),
              if (value.cartItems.isNotEmpty)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      value.cartItems.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // let's order
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Let's order some new products",
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10.0),
            //divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),

            // items and grid view
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("New products", style: TextStyle(fontSize: 20.0)),
            ),

            // grid view of the products
            Expanded(
              child: FutureBuilder(
                future: Provider.of<CartModel>(
                  context,
                  listen: false,
                ).getPost(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // show loader while fetching
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    // show error if API fails
                    return Center(
                      child: Text("Error loading products: ${snapshot.error}"),
                    );
                  }

                  // products loaded → show grid
                  return Consumer<CartModel>(
                    builder: (context, value, child) {
                      return GridView.builder(
                        itemCount: value.shopItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.2,
                            ),
                        itemBuilder: (context, index) {
                          return ProductsItems(
                            ID: value.shopItems[index][0],
                            name: value.shopItems[index][1],
                            description: value.shopItems[index][2],
                            image_url: value.shopItems[index][3],
                            price: value.shopItems[index][4],
                            onPressed: () {
                              Provider.of<CartModel>(
                                context,
                                listen: false,
                              ).addItemToCart(value.shopItems[index]);
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
