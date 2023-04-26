import 'package:afisha_market/pages/settings/components/editList.dart';
import 'package:afisha_market/pages/utils/circleImage.dart';
import 'package:afisha_market/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/const.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Настройки профиля',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: const [
         Expanded(child: EditList())
        ],
      ),
    );
  }
}
