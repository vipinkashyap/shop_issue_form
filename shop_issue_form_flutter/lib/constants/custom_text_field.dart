import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final String name;
  final String labelTextName;
  final int maxLines;
  const CustomTextField(
      {Key? key,
      required this.focusNode,
      required this.name,
      required this.labelTextName,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      focusNode: focusNode,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: labelTextName,
      ),
      name: name,
      maxLines: maxLines,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.min(context, 3),
        FormBuilderValidators.required(context)
      ]),
    );
  }
}
