import 'package:flutter/material.dart';
typedef ValidatorType = String? Function(String?);

class CustomFormField extends StatefulWidget {
  String label;
  TextInputType KeyboardType;
  bool isPassword;
  ValidatorType validate;
  TextEditingController controller;
  int? maxLength ;
  CustomFormField({this.maxLength, required this.label, required this.controller,required this.KeyboardType, this.isPassword = false, required this.validate});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObsecured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      validator: widget.validate,
      keyboardType: widget.KeyboardType,
      obscuringCharacter: "*",
      obscureText: widget.isPassword==true
          ?isObsecured
          :false,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 18),
      decoration: InputDecoration(
        counterText: "", // To hide the maxLength label in the screen
        suffixIcon: widget.isPassword
            ?IconButton(
              onPressed: () {
                setState(() {
                  isObsecured = !isObsecured;
                });
            },icon:Icon(
              isObsecured
                  ?Icons.visibility_outlined
                  :Icons.visibility_off_outlined,
                  color:Theme.of(context).colorScheme.primary,))
            :null,
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelSmall
      ),
    );
  }
}
