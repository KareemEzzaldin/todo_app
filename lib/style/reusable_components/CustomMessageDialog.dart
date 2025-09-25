import 'package:flutter/material.dart';

class CustomMessageDialog extends StatelessWidget {
  final String message ;
  final String positiveBtnTitle ;
  final void Function() positiveBtnPress;
  String? negativeBtnTitle;
  void Function()? negativeBtnPress;
  CustomMessageDialog({
    required this.message,
    this.positiveBtnTitle = 'ok',
    required this.positiveBtnPress,
    this.negativeBtnPress,
    this.negativeBtnTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(onPressed: positiveBtnPress, child: Text(positiveBtnTitle)),
        if(negativeBtnTitle!=null)
          TextButton(onPressed: negativeBtnPress, child: Text(negativeBtnTitle!)),
          // you can't put {} for if loop inside a widget
          // so if you want to make more than one widget in the if condition you make another list
          // ...[ // (...) this 3 dots let you make a list inside a list
          //   TextButton(onPressed: negativeBtnPress, child: Text(negativeBtnTitle!)),
          //   TextButton(onPressed: negativeBtnPress, child: Text(negativeBtnTitle!)),
          // ]
      ],
    );
  }
}
