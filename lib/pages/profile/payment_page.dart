import 'package:afisha_market/pages/profile/components/payment_submit_page.dart';
import 'package:afisha_market/pages/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedValue = 0;
  final paymentOptionsList = [
    '100 000',
    '30 000',
  ];
  bool isSelected = true;

  bool isClick = false;
  bool isPayme = false;
  bool isAgent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.2),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: paymentOptionsList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.4), width: 2),
                      borderRadius: BorderRadius.circular(12)),
                  child: RadioListTile(
                    title: Text(paymentOptionsList[index]),
                    value: index,
                    secondary: Icon(Icons.info_outline),
                    groupValue: _selectedValue,
                    onChanged: (int? value) {
                      setState(() {
                        _selectedValue = value!;
                        print('_selectedValue : $_selectedValue');
                      });
                    },
                  ),
                );
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClick = true;
                        isPayme = false;
                        isAgent = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isClick ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/click.png',
                        color: Colors.black,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClick = false;
                        isPayme = true;
                        isAgent = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isPayme ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/payme.png',
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isClick = false;
                        isPayme = false;
                        isAgent = true;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isAgent ? mainColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/agent.png',
                            width: 50,
                            height: 50,
                          ),
                          Text('Agent')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (isPayme || isClick || isAgent)
                  ? () {
                if(isPayme || isClick){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: MyText(
                        "This payment method is still under development!",
                      ),
                    ),
                  );
                }else{
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => PaymentSubmitPage(
                          amount: paymentOptionsList[_selectedValue].replaceAll(' ', ''),
                        )),
                  );
                }

                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: MyText(
                            "Please select on of the payment method!",
                          ),
                        ),
                      );
                    },
              child: Container(
                width: MediaQuery.of(context).size.width - 24,
                height: 56,
                decoration: BoxDecoration(
                  color:(isPayme || isClick || isAgent)? mainColor:disableColor ,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
