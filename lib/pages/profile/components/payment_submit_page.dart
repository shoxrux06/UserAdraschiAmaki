import 'package:afisha_market/core/bloc/payment/payment_bloc.dart';
import 'package:afisha_market/core/bloc/payment/payment_state.dart';
import 'package:afisha_market/core/utils/app_helpers.dart';
import 'package:afisha_market/pages/main_container.dart';
import 'package:afisha_market/pages/utils/custom_button_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/const.dart';
import '../../utils/custom_button.dart';
import '../../utils/utils.dart';

class PaymentSubmitPage extends StatefulWidget {
  const PaymentSubmitPage({Key? key, required this.amount}) : super(key: key);

  final String amount;

  @override
  State<PaymentSubmitPage> createState() => _PaymentSubmitPageState();
}

class _PaymentSubmitPageState extends State<PaymentSubmitPage> {
  final secretCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(('amount -->${widget.amount}'));
    return BlocConsumer<PaymentBloc, PaymentState>(listener: (context, state) {
      if(state.isPayed){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainContainer()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: MyText(
              state.message,
            ),
          ),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Agent\'s code',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: secretCodeController,
                decoration: AppHelpers.decoration(
                    isHintText: true, text: 'Secret code'),
              ),
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
                return CustomButtonTwo(
                  isLoading: state.isPaying,
                  'Submit',
                  onTap: () {
                    if(secretCodeController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                            content: MyText(
                              "Enter secret code",
                            ),
                          )
                      );
                    }else {
                      context.read<PaymentBloc>().add(CreateTransactionEvent(
                        widget.amount,
                        secretCodeController.text,
                        context,
                      ));
                    }
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }
}
