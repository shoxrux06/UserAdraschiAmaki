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
// class EmptySignIn extends StatefulWidget {
//   final phoneNumber;
//   final pass;
//
//   const EmptySignIn({Key? key, this.phoneNumber, this.pass}) : super(key: key);
//
//   @override
//   State<EmptySignIn> createState() => _EmptySignInState();
// }
//
// class _EmptySignInState extends State<EmptySignIn> {
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
//           Navigator.popUntil(
//               context, ModalRoute.withName(Navigator.defaultRouteName));
//           // Navigator.push(context,
//           //     MaterialPageRoute(builder: (context) => const Success()));
//
//           // Navigator.pushNamed(context, '/user',
//           //     arguments: SignInRequest(
//           //         login: widget.phoneNumber, password: widget.pass));
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }
