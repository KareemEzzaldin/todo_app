import 'package:flutter/material.dart';
typedef authFunction = Function();
class CustomButton extends StatelessWidget {
  String label;
  authFunction onClick;
  CustomButton({required this.label, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
            Icon(Icons.arrow_forward,color: Colors.white,)
          ],
        ))
    ;
  }
}
