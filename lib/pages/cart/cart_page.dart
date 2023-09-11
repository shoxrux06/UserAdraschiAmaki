import 'package:afisha_market/core/bloc/cart/cart_bloc.dart';
import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/cart/cart_state.dart';
import 'package:afisha_market/core/utils/local_storage.dart';
import 'package:afisha_market/db/db_helper.dart';
import 'package:afisha_market/pages/auth/signIn/SignInScreen.dart';
import 'package:afisha_market/pages/auth/signUp/SignUpScreen.dart';
import 'package:afisha_market/pages/cart/widgets/cart_item_widget.dart';
import 'package:afisha_market/pages/order/order_page.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/models/locale_product.dart';


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
  int totalSum2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          print('Umumiy summa ${state.totalSum??0}');
          if (state.productList == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state.productList.isEmpty?? false){
            return const Center(
              child: Text('Cart is empty'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(cartItem: state.productList[index],index: index);
                    },
                  ),
                ),
                Row(
                  children: [
                    const Text('Total sum'),
                    const Spacer(),
                    Text('${state.totalSum} sum'),
                  ],
                ),
                const SizedBox(height: 20,),
                CustomButtonTwo('Rasmiylashtirish', onTap: (){
                  final token = LocalStorage.instance.getToken();
                  if(token.isEmpty){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SignUpScreen(isFromCart: true,)));
                  }else{
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderPage()));
                  }
                },),
                SizedBox(height: 40,),
              ],
            ),
          );
        },
      ),
    );
  }
}
