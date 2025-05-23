import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/resturant.dart';
import 'package:food_delivery_app/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart'; // Added import for MyCartTile
import 'package:food_delivery_app/components/my_button.dart'; // Added import for MyButton

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      // cart
      final userCart = restaurant.cart;

      // scaffold UI
      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            // clear cart button
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                "Are you sure you want to clear the cart?"),
                            actions: [
                              // cancel button
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              ),
                              // yes button
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  restaurant.clearCart();
                                },
                                child: const Text("Yes"),
                              )
                            ],
                          ));
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Column(
          children: [
            // list of cart items
            Expanded(
              child: userCart.isEmpty
                  ? const Center(
                      child: Text("Cart is Empty..."),
                    )
                  : ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        // get individual Cart item
                        final cartItem = userCart[index];

                        // return Cart title UI
                        return MyCartTile(
                          cartItem: cartItem,
                        );
                      },
                    ),
            ),

            // button to pay
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: MyButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                ),
                text: "Go to checkout",
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      );
    });
  }
}
