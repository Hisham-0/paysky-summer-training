import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stripe_task/model/cart_model.dart';
import 'package:stripe_task/model/stripe_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 40.0, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, thickness: 1, color: Colors.grey[300]),
        ),
      ),

      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "My cart",
                  style: GoogleFonts.notoSerif(fontSize: 60.0),
                ),
              ),

              // list of cart items
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  value.cartItems[index][3],
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.image_not_supported,
                                      size: 80,
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 15),

                              // Item information
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.cartItems[index][1],
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      "\$${value.cartItems[index][4]} x ${value.getQuantity(value.cartItems[index][0])} pieces",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Remove from cart button
                              IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                onPressed: () => Provider.of<CartModel>(
                                  context,
                                  listen: false,
                                ).removeItemFromCart(index),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // total price + check out
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border(
                      top: BorderSide(color: Colors.green.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // total price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total price ",
                            style: TextStyle(
                              color: Colors.green[100],
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            "\$${value.calculatePrice().toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.green[200],
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      //  pay now button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            final cartModel = Provider.of<CartModel>(
                              context,
                              listen: false,
                            );
                            final totalPaymentPrice = cartModel
                                .calculatePrice();

                            int paymentSuccess = await StripeService.instance
                                .makePayment(totalPaymentPrice);

                            if (paymentSuccess == 1) {
                              cartModel.clearCart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Payment successful",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else if (paymentSuccess == 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Pyment Process Has Been Canceled ",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Cart is Empty",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          },

                          child: Row(
                            children: [
                              Text(
                                "pay now",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
