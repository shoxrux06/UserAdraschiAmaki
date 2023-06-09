import 'package:afisha_market/core/bloc/add/create_bloc.dart';
import 'package:afisha_market/pages/add/add_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/profile/profile/profileBloc.dart';
import '../../core/bloc/profile/profile/profileState.dart';
import '../../core/data/source/remote/response/GetProfileResponse.dart';
import '../../core/di/dependency_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddScreen extends StatefulWidget {
  final ProductDetail? productDetail;

  const AddScreen({Key? key, this.productDetail}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    print('PHOTOS -> ${widget.productDetail?.photos}');
    return BlocProvider(
        create: (_) => CreateBloc(productRepository),
        child: SafeArea(
          child: Scaffold(
            body: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if(state is GetProfileState){
                  if((state.profileResponse.user?.status == 'Faol') || (state.profileResponse.user?.status == 'Активный')){
                    return Container(
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                      child: AddScreenForm(
                        productDetail: widget.productDetail,
                      ),
                    );
                  }else{
                    return Container(
                      margin: EdgeInsets.all(24),
                      color: Colors.lightBlueAccent.withOpacity(0.2),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/noprof.jpg'),
                          const SizedBox(height: 24,),
                          Text(l10n?.youHaventMadePayment??''),
                        ],
                      ),
                    );
                  }

                }else{
                  return Container(
                    padding: EdgeInsets.all(24),
                    color: Colors.lightBlueAccent.withOpacity(0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/noprof.jpg'),
                        const SizedBox(height: 24,),
                        Text(l10n?.youHaventMadePayment??''),
                      ],
                    ),
                  );
                }
              }
            ),
          ),
        ));
  }
}
