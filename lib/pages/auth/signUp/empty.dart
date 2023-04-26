// import 'package:afisha_market/const.dart';
// import 'package:afisha_market/core/bloc/auth/authBloc.dart';
// import 'package:afisha_market/core/bloc/auth/authState.dart';
// import 'package:afisha_market/core/data/source/remote/request/SignUpRequest.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/data/source/remote/request/SignInRequest.dart';
// import '../../utils/utils.dart';
//
// class EmptySignUp extends StatefulWidget {
//   final String phoneNumber;
//
//   const EmptySignUp({
//     Key? key,
//     required this.phoneNumber,
//   }) : super(key: key);
//
//   @override
//   State<EmptySignUp> createState() => _EmptySignUpState();
// }
//
// class _EmptySignUpState extends State<EmptySignUp> {
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
//         print('phone from sign up empty ${AppConst.pHONENUMBER}');
//         if (state is AuthSuccessState) {
//           Navigator.pushNamed(context, '/otp', arguments: widget.phoneNumber);
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
