import 'package:flutter/material.dart';

import 'const.dart';

class CustomButtonTwo extends StatefulWidget {
  final bool isLoading ;
  final String buttonText;
  final Function()? onTap;

  const CustomButtonTwo(
      this.buttonText, {
        this.isLoading = false,
        this.onTap,
        super.key,
      });

  @override
  State<CustomButtonTwo> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonTwo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              disabledBackgroundColor: mainColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              elevation: 2),
          onPressed: widget.onTap,
          child: widget.isLoading? const Center(child: SizedBox(width: 24,height: 24,child: CircularProgressIndicator(color: Colors.white,),),):
          Text(
            widget.buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}