import 'dart:html';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomNumberField extends StatelessWidget {
  final FocusNode focusName;
  final String name;
  final String labelTextName;
  const CustomNumberField(
      {Key? key,
      required this.focusName,
      required this.name,
      required this.labelTextName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: focusName,
      name: name,
      decoration: InputDecoration(
        labelText: labelTextName,
      ),
      valueTransformer: (text) => num.tryParse(text!),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context),
        FormBuilderValidators.numeric(context),
      ]),
      keyboardType: TextInputType.number,
    );
  }
}
