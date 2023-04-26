// import 'package:afisha_market/core/data/source/remote/request/VerifyRequest.dart';
// import 'package:afisha_market/pages/utils/const.dart';
// import 'package:afisha_market/pages/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pinput/pinput.dart';
//
//
// class OTPScreenNew extends StatefulWidget {
//   const OTPScreenNew({Key? key}) : super(key: key);
//
//   @override
//   State<OTPScreenNew> createState() => _OTPScreenNewState();
// }
//
// class _OTPScreenNewState extends State<OTPScreenNew> {
//   final controller = TextEditingController();
//   final focusNode = FocusNode();
//
//   @override
//   void dispose() {
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }
//
//   bool showError = false;
//
//   void _submitCode(Bloc bloc, String phoneNumber) {
//     var code = controller.text;
//     if (code.length != 5) {
//     } else {
//       bloc.add(VerifyEventWithRequest(
//           VerifyRequest(phone: phoneNumber, code: code)));
//       Navigator.pushReplacementNamed(context, '/user',
//           arguments: VerifyRequest(phone: phoneNumber, code: code));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     RouteSettings settings = ModalRoute.of(context)!.settings;
//     var phoneNumber = settings.arguments;
//     final bloc = context.read<VerifyBloc>();
//     const length = 5;
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 60,
//       textStyle: const TextStyle(
//         fontSize: 22,
//       ),
//       decoration: BoxDecoration(
//         color: helperColor,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.transparent),
//       ),
//     );
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'номлаш кере',
//           style: TextStyle(color: mainColor, fontWeight: FontWeight.w500),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           children: [
//             const Spacer(
//               flex: 1,
//             ),
//             Center(
//               child: SizedBox(
//                 height: 68,
//                 child: Pinput(
//                   length: length,
//                   controller: controller,
//                   focusNode: focusNode,
//                   defaultPinTheme: defaultPinTheme,
//                   focusedPinTheme: defaultPinTheme.copyWith(
//                     height: 68,
//                     width: 64,
//                     decoration: defaultPinTheme.decoration!.copyWith(
//                       border: Border.all(color: mainColor),
//                     ),
//                   ),
//                   errorPinTheme: defaultPinTheme.copyWith(
//                     decoration: BoxDecoration(
//                       color: disableColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             MyText(
//               'На ваш номер был отправлен код подтверждения, введите его чтобы продолжить',
//               color: mainColor,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             MyBigButton(
//               'Далее',
//               onTap: () {
//                 print("phoneeee ${phoneNumber.toString()}");
//                 _submitCode(bloc, phoneNumber.toString());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
