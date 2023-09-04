import 'package:afisha_market/core/bloc/cart/cart_bloc.dart';
import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:afisha_market/pages/cart/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/local_storage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartInitEvent());
    super.initState();
  }

  int totalSum = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print('Cart productList >>> ${state.productList}');
          state.productList?.forEach((element) {
            totalSum+=element.totalSum;
          });
          // if (state.productList != null) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if(state.productList?.isEmpty?? false){
          //   return const Center(
          //     child: Text('Cart is empty'),
          //   );
          // }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.productList?.length??0,
                    itemBuilder: (context, index) {
                      return CartItemWidget(cartItem: state.productList![index],index: index);
                    },
                  ),
                ),

                Row(
                  children: [
                    const Text('Total sum'),
                    const Spacer(),
                    Text('$totalSum sum'),
                  ],
                ),
                SizedBox(height: 100,),
              ],
            ),
          );
        },
      ),
    );
  }
}
