import 'package:flutter/material.dart';

import 'const.dart';

class CustomButton extends StatefulWidget {
  final bool isLoading ;
  final String buttonText;
  final Function()? onTap;

  const CustomButton(
      this.buttonText, {
        this.isLoading = false,
        this.onTap,
        super.key,
      });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
              disabledBackgroundColor: disableColor,
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