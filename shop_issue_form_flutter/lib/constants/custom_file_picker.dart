import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class CustomFilePicker extends StatelessWidget {
  final FocusNode focusNode;
  final String name;
  final String labelTextName;
  const CustomFilePicker(
      {Key? key,
      required this.focusNode,
      required this.name,
      required this.labelTextName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          labelText: labelTextName,
          labelStyle: TextStyle(fontWeight: FontWeight.w600)),
      focusNode: focusNode,
      name: name,
      previewImages: false,
      allowMultiple: false,
      maxFiles: 1,
      onFileLoading: (status) => const CircularProgressIndicator(),
    );
  }
}
