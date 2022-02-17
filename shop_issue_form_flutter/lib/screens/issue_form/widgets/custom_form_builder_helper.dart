import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

enum FieldType {
  text,
  date,
  textfield,
  number,
  rating,
  checkbox,
  fileupload,
  choicechip
}

class CustomFormBuilderFieldHelper extends StatelessWidget {
  static const TextStyle kLabelStyle = TextStyle(fontWeight: FontWeight.w500);
  static OutlineInputBorder kBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(12));
  final FieldType fieldType;
  final FocusNode focusNode;
  final String? labelText;
  final String name;
  final int? maxLines;
  const CustomFormBuilderFieldHelper(
      {Key? key,
      required this.fieldType,
      required this.focusNode,
      this.labelText,
      required this.name,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (fieldType) {
      case FieldType.text:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderTextField(
            focusNode: focusNode,
            decoration: InputDecoration(
              border: kBorder,
              labelText: labelText,
            ),
            name: name,
            maxLines: 1,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.min(context, 3),
              FormBuilderValidators.required(context)
            ]),
          ),
        );
      case FieldType.textfield:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderTextField(
            focusNode: focusNode,
            decoration: InputDecoration(
              border: kBorder,
              labelText: labelText,
            ),
            name: name,
            maxLines: 4,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.min(context, 3),
              FormBuilderValidators.required(context)
            ]),
          ),
        );
      case FieldType.number:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderTextField(
            focusNode: focusNode,
            name: name,
            decoration: InputDecoration(
              labelStyle: kLabelStyle,
              border: kBorder,
              labelText: labelText,
            ),
            valueTransformer: (text) => num.tryParse(text!),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.numeric(context),
            ]),
            keyboardType: TextInputType.number,
          ),
        );
      case FieldType.rating:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderRatingBar(
            focusNode: focusNode,
            validator: FormBuilderValidators.required(context),
            decoration: InputDecoration(border: kBorder, labelText: labelText),
            name: name,
            initialValue: 0.0,
            maxRating: 5.0,
          ),
        );

      case FieldType.checkbox:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderCheckbox(
            focusNode: focusNode,
            validator: FormBuilderValidators.required(context),
            name: name,
            initialValue: false,
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'I have read and agree to the ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Terms and Conditions',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        );
      case FieldType.fileupload:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderFilePicker(
              name: name,
              focusNode: focusNode,
              maxFiles: 1,
              onFileLoading: (status) => const CircularProgressIndicator(),
              decoration: InputDecoration(
                border: kBorder,
                labelText: labelText,
                labelStyle: kLabelStyle,
              )),
        );
      case FieldType.choicechip:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderChoiceChip(
            backgroundColor: Colors.grey[300],
            selectedColor: Colors.blue[400],
            elevation: 2,
            padding: const EdgeInsets.all(8),
            focusNode: focusNode,
            initialValue: 'low',
            name: name,
            decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
                hintStyle: const TextStyle(height: 5)),
            spacing: 12,
            options: const [
              FormBuilderFieldOption(value: 'low', child: Text('Low')),
              FormBuilderFieldOption(value: 'med', child: Text('Med')),
              FormBuilderFieldOption(value: 'high', child: Text('High')),
            ],
          ),
        );
      case FieldType.date:
        return FormBuilderDateTimePicker(
          name: name,
          focusNode: focusNode,
          firstDate: DateTime.now(),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormBuilderTextField(
            focusNode: focusNode,
            decoration: InputDecoration(
              border: kBorder,
              labelText: labelText,
            ),
            name: name,
            maxLines: maxLines,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.min(context, 3),
              FormBuilderValidators.required(context)
            ]),
          ),
        );
    }
  }
}
