import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class IssueForm extends StatefulWidget {
  const IssueForm({Key? key}) : super(key: key);

  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  bool _saveButtonTapped = false;
  String _buttonText = 'SAVE TO GOOGLE CLOUD';

  // Form key
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  // Focus Nodes
  final FocusNode _customerFocus = FocusNode();
  final FocusNode _epcContractorFocus = FocusNode();
  final FocusNode _siteLocationFocus = FocusNode();
  final FocusNode _equipmentRatingFocus = FocusNode();
  final FocusNode _issuePriorityFocus = FocusNode();
  final FocusNode _costFocus = FocusNode();
  final FocusNode _resourceRequirementsFocus = FocusNode();
  final FocusNode _invoiceFocus = FocusNode();
  final FocusNode _tnsFocus = FocusNode();

  _handleSubmit() {
    _saveButtonTapped = true;
    setState(() => _buttonText = 'WRITING TO DATABASE');
    if (_fbKey.currentState!.saveAndValidate()) {
      FirebaseFirestore.instance.collection('isues').doc().set({
        'epcContractor': _fbKey.currentState!.value['epc_contractor'] as String,
        'customer': _fbKey.currentState!.value['customer'] as String,
        'siteLocation': _fbKey.currentState!.value['site_location'] as String,
        'equipmentRating':
            _fbKey.currentState!.value['equipment_rating'] as double,
        'issuePriority': _fbKey.currentState!.value['issue_priority'] as String,
        'cost': _fbKey.currentState!.value['cost'] as double,
        'resourceRequirements':
            _fbKey.currentState!.value['resource_requirements'] as String,
        'invoice': _fbKey.currentState!.value['invoice'] as int,
      }).then((value) {
        setState(() => _buttonText = 'WRITTEN SUCCESSFULLY');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop Issue Tracker'),
        ),
        body: SafeArea(
          child: FormBuilder(
            key: _fbKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  //Stage 1 form input

                  //1. Epc Contractor
                  FormBuilderTextField(
                    focusNode: _epcContractorFocus,
                    decoration:
                        const InputDecoration(labelText: 'Epc Contractor'),
                    name: 'epc_contractor',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 3),
                      FormBuilderValidators.required(context)
                    ]),
                  ),
                  //2. Customer
                  FormBuilderTextField(
                    focusNode: _customerFocus,
                    decoration: const InputDecoration(labelText: 'Customer'),
                    name: 'customer',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 3),
                      FormBuilderValidators.required(context)
                    ]),
                  ),
                  FormBuilderTextField(
                    focusNode: _siteLocationFocus,
                    decoration:
                        const InputDecoration(labelText: 'Site Location'),
                    name: 'site_location',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 3),
                      FormBuilderValidators.required(context)
                    ]),
                  ),
                  FormBuilderRatingBar(
                    focusNode: _equipmentRatingFocus,
                    validator: FormBuilderValidators.required(context),
                    decoration:
                        const InputDecoration(labelText: 'Equipment Rating'),
                    name: 'equipment_rating',
                    initialValue: 0.0,
                    maxRating: 5.0,
                  ),
                  FormBuilderChoiceChip(
                    focusNode: _issuePriorityFocus,
                    initialValue: 'low',
                    name: 'issue_priority',
                    decoration: const InputDecoration(
                      labelText: 'Choose Issue Priority',
                    ),
                    options: const [
                      FormBuilderFieldOption(value: 'low', child: Text('Low')),
                      FormBuilderFieldOption(value: 'med', child: Text('Med')),
                      FormBuilderFieldOption(
                          value: 'high', child: Text('High')),
                    ],
                  ),
                  FormBuilderTextField(
                    focusNode: _resourceRequirementsFocus,
                    decoration: const InputDecoration(
                        labelText: 'Resource Requirements'),
                    name: 'resource_requirements',
                    maxLines: 4,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.min(context, 3),
                      FormBuilderValidators.required(context)
                    ]),
                  ),
                  FormBuilderTextField(
                    focusNode: _costFocus,
                    name: 'cost',
                    decoration: const InputDecoration(
                      labelText: 'Enter Cost',
                    ),
                    valueTransformer: (text) => num.tryParse(text!),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 100000),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    focusNode: _invoiceFocus,
                    name: 'invoice',
                    decoration: const InputDecoration(
                      labelText: 'Invoice ID for customer',
                    ),
                    valueTransformer: (text) => num.tryParse(text!),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderCheckbox(
                    focusNode: _tnsFocus,
                    validator: FormBuilderValidators.required(context),
                    name: 'accept_terms',
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
                  const SizedBox(height: 20),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_buttonText),
                    ),
                    onPressed: () => _handleSubmit(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null) {
                        Uint8List? file = result.files.first.bytes;
                        String fileName = result.files.first.name;

                        UploadTask task = FirebaseStorage.instance
                            .ref()
                            .child(
                                "files/$fileName") // Code failing on this line
                            // refer this answer - https://stackoverflow.com/questions/65048371/fire-storage-exception-firebase-storage-unauthorized-user-is-not-authorized-t
                            .putData(file!);

                        task.snapshotEvents.listen((event) {
                          setState(() {
                            var progress = ((event.bytesTransferred.toDouble() /
                                    event.totalBytes.toDouble()) *
                                100);
                            print(progress);
                          });
                        });
                      }
                    },
                    child: const Text('UPLOAD'),
                  )
//                   ElevatedButton(
//                       onPressed: () async {
//                         final results = await FilePicker.platform.pickFiles(
//                             allowMultiple: false,
//                             type: FileType.custom,
//                             allowedExtensions: ['pdf', 'png']);
//                         if (results == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('No file selected'),
//                             ),
//                           );
//                         }
//                         //  final path = results!.files.single.path;
// Uint8List? path = results!.files.single.bytes;
//                         final fileName = results.files.single.name;
//                         storage
//                             .uploadFile(path, fileName)
//                             .then((value) => print('DONE!'));
//                       },
//                       child: Text('Select file'))
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
