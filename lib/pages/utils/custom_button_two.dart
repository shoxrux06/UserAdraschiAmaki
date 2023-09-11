import 'package:flutter/material.dart';

import 'const.dart';

class CustomButtonTwo extends StatefulWidget {
  final bool isLoading;
  final bool isActive;
  final String buttonText;
  final Function()? onTap;

  const CustomButtonTwo(
      this.buttonText, {
        this.isLoading = false,
        this.isActive = true,
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
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              color: widget.isActive? blueColor: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              border: Border.all(
                width: 1,
                color: widget.isActive? blueColor: Colors.grey,
              )
          ),
          child: widget.isLoading? Center(child: SizedBox(width: 24,height: 24,child: CircularProgressIndicator(color: blueColor,),),):
          Center(
            child: Text(
              widget.buttonText,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}