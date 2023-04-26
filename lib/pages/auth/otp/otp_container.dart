import 'package:afisha_market/const.dart';
import 'package:afisha_market/core/bloc/auth/authEvent.dart';
import 'package:afisha_market/core/bloc/auth/authState.dart';
import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../../../core/bloc/auth/authBloc.dart';
import '../../utils/const.dart';
import '../../utils/utils.dart';

class OTPContainer extends StatefulWidget {
  final String phone;

  const OTPContainer({Key? key, required this.phone}) : super(key: key);

  @override
  State<OTPContainer> createState() => _OTPContainerState();
}

class _OTPContainerState extends State<OTPContainer> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  bool showError = false;

  static const length = 5;
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
    ),
    decoration: BoxDecoration(
      color: helperColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = BlocProvider.of<AuthBloc>(context);
    RouteSettings settings = ModalRoute.of(context)!.settings;
    var phoneNumber = settings.arguments as String;
    print("phoneNumber $phoneNumber");
    print('widget.phone ${widget.phone}');

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: MyText(
            "Something went wrong",
          )));
        }
      },
      builder: (context, state) {
        if (state is AuthSuccessState) {
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/images/success.json',
                    width: 180, height: 180),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: MyBigButton(
                    'OK',
                    onTap: () {
                      // Navigator.popUntil(context,
                      //     ModalRoute.withName(Navigator.defaultRouteName));
                    },
                  ),
                )
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(
                flex: 1,
              ),
              Center(
                child: SizedBox(
                  height: 68,
                  child: Pinput(
                    length: length,
                    controller: controller,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      height: 68,
                      width: 64,
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: mainColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      decoration: BoxDecoration(
                        color: disableColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              MyText(
                'На ваш номер был отправлен код подтверждения, введите его чтобы продолжить',
                color: mainColor,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // OTPEmpty(
              //   phoneNumber: AppConst.pHONENUMBER,
              //   code: controller.text,
              // ),
              MyBigButton(
                'Далее',
                onTap: () {
                  var code = controller.text;
                  bloc.add(VerifyEvent(
                      VerifyRequest(phone: AppConst.pHONENUMBER, code: code)));
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                  print("OTPPPPP ${AppConst.pHONENUMBER},$code");
                  // Navigator.popUntil(
                  //     context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
