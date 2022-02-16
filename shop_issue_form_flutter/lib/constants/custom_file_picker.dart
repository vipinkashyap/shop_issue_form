import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class CustomFilePicker extends StatelessWidget {
  final FocusNode focusNode;
  final String name;
  const CustomFilePicker(
      {Key? key, required this.focusNode, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderFilePicker(
      focusNode: focusNode,
      name: name,
      previewImages: false,
      allowMultiple: false,
      maxFiles: 1,
      onFileLoading: (status) => const CircularProgressIndicator(),
    );
  }
}
