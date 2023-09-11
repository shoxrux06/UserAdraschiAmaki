import 'package:afisha_market/core/bloc/cart/cart_event.dart';
import 'package:afisha_market/core/bloc/payment/payment_bloc.dart';
import 'package:afisha_market/core/bloc/payment/payment_state.dart';
import 'package:afisha_market/pages/cart/widgets/cart_item_widget.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/order/widgets/my_radio_list_tile.dart';
import 'package:afisha_market/pages/order/widgets/order_products_item.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/bloc/cart/cart_bloc.dart';
import '../../core/data/models/locale_product.dart';
import '../../db/db_helper.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<LocaleProduct> localProducts = [];
  int _value = -1;
  int quantity = 0;
  int totalSum = 0;
  String paymentType = '';

  @override
  void initState() {
    initProducts();
    super.initState();
  }

  initProducts() async {
    localProducts = await DbManager().getDataList();
    localProducts.forEach((element) {
      setState(() {
        quantity += element.quantity;
        totalSum += (element.quantity * int.parse(element.price));
      });

    });
    setState(() {});
    print('localProducts <$localProducts>');
  }
  bool isPaymentTypeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyurtmani rasmiylashtirish'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: localProducts.length,
                    itemBuilder: (context, index) {
                      return OrdersProductItem(
                          cartItem: localProducts[index]);
                    },
                  ),
                  SizedBox(height: 24,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Text('Buyurtmangiz', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        Row(children: [
                          Expanded(child: Text('Mahsulotlar ($quantity):')),
                          Text('$totalSum som'),
                        ],),
                        SizedBox(height: 8,),
                        Row(children: [
                          Expanded(child: Text('Jami:')),
                          Text('$totalSum som',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        ],),
                        SizedBox(height: 8,),
                        Text('Tolov turi',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  MyRadioListTile(
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        paymentType= 'click';
                        isPaymentTypeSelected = true;
                        _value = value!;
                      });
                    },
                    leading: 'assets/images/click.png',
                    title: const Text('Click'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MyRadioListTile(
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        paymentType= 'payme';
                        isPaymentTypeSelected = true;
                        _value = value!;
                      });
                    },
                    leading: 'assets/images/payme.png',
                    title: const Text('Payme'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4)
                ]
            ),
            child: Column(
              children: [
                SizedBox(height: 8,),
                Row(children: [
                  Expanded(child: Text('Jami:')),
                  Text('$totalSum som',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],),
                SizedBox(height: 8,),
                BlocConsumer<PaymentBloc,PaymentState>(builder: (context,state){
                  return CustomButtonTwo(
                    isPaymentTypeSelected?'Karta orqali tolash':'Buyurtmani rasmiylashtirish',
                    isActive: isPaymentTypeSelected,
                    isLoading: state.isCreatingOrder??false,
                    onTap: () {
                      context.read<PaymentBloc>().add(CreateOrderEvent(context, paymentType));
                    },
                  );
                }, listener: (context,state){
                  if(state.isCreatedOrder?? false) {
                    _launchUrl(state.ordersResponse?.clickUrl??'');
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainContainer()));
      context.read<CartBloc>().add(CartClearEvent());
    }
  }
}
