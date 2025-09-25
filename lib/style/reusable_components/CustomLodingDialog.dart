import 'package:flutter/material.dart';

class CustomLodingDialog extends StatelessWidget {
  const CustomLodingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height*0.07,
        child: Center(child : CircularProgressIndicator()),
      ),
    );
  }
}
