// import 'package:afisha_market/core/bloc/auth/authBloc.dart';
// import 'package:afisha_market/core/bloc/auth/authState.dart';
// import 'package:afisha_market/pages/splash/splash_screen.dart';
// import 'package:afisha_market/pages/splash/success.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/data/source/remote/request/SignInRequest.dart';
// import '../../utils/utils.dart';
//
// class OTPEmpty extends StatefulWidget {
//   final phoneNumber;
//   final code;
//
//   const OTPEmpty({Key? key, this.phoneNumber, this.code}) : super(key: key);
//
//   @override
//   State<OTPEmpty> createState() => _OTPEmptyState();
// }
//
// class _OTPEmptyState extends State<OTPEmpty> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: MyText(
//             "Something went wrong",
//           )));
//         }
//       },
//       builder: (context, state) {
//         if (state is AuthSuccessState) {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => const Success()));
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
