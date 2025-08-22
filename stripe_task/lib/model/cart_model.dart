import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartModel extends ChangeNotifier {
  late List _shopItems = [
    //list of items to sale
    // [ id , name ,description , image_url , price ]
  ];

  // get the API with http
  Future<void> getPost() async {
    try {
      final url = Uri.parse(
        "https://b5a0bfa1-6d8b-4c44-862b-68d03d2d4521.mock.pstmn.io/products",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        print(response.body);
        print("done");
        _shopItems = data.map((item) {
          return [
            item['id'].toString(),
            item['name'].toString(),
            item['description'].toString(),
            item['image_url'].toString(),
            (item['price'] as num).toDouble(),
          ];
        }).toList();

        notifyListeners();
      } else {
        print("API error: ${response.statusCode}");
      }
    } catch (e) {
      print("API not available: $e");
    }
  }

  //list of items in the cart
  List _cartItems = [];

  // {id , pieces No}
  final Map<String, int> _itemQuantities = {};

  void increaseQuantity(String id) {
    _itemQuantities[id] = getQuantity(id) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (getQuantity(id) > 0) {
      _itemQuantities[id] = getQuantity(id) - 1;
      notifyListeners();
    }
    if (getQuantity(id) == 0) {
      _cartItems.removeWhere((cartItem) => cartItem[0] == id);
      notifyListeners();
      print("item removed because quantity is 0");
    }
  }

  // search on item in cart

  bool searchOnItem(List<dynamic> item) {
    String id = item[0]; // The product ID
    return _cartItems.any((cartItem) => cartItem[0] == id);
  }

  // add item to cart
  void addItemToCart(List<dynamic> item) {
    String id = item[0];

    // If item is not in the cart
    if (!searchOnItem(item)) {
      // If quantity is 0  set it to 1
      if (getQuantity(id) == 0) {
        _itemQuantities[id] = 1;
      }
      _cartItems.add(item);
      print("item added");
    } else {
      // If item already in the cart and quantity is 0, remove it
      if (getQuantity(id) == 0) {
        _cartItems.removeWhere((cartItem) => cartItem[0] == id);
        print("item removed because quantity is 0");
      } else {
        print("item already in cart, updated quantity: ${getQuantity(id)}");
      }
    }

    notifyListeners();
  }

  // remove item from the cart
  void removeItemFromCart(int index) {
    String id = _cartItems[index][0];
    _itemQuantities[id] = 0;

    _cartItems.removeAt(index);
    notifyListeners();
    print("item removed");
  }

  //calculate price
  double calculatePrice() {
    double total = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      String id = _cartItems[i][0];
      double price = _cartItems[i][4];
      int quantity = getQuantity(id);
      total += price * quantity;
    }
    return total;
  }


 //  clear cart
  void clearCart() {
    cartItems.clear();
    _itemQuantities.clear();
    notifyListeners();
  }







  // get methods
  get cartItems => _cartItems;

  get shopItems => _shopItems;

  int getQuantity(String id) => _itemQuantities[id] ?? 0;
}
