import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/services.dart';

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
  final FocusNode _idFocus = FocusNode();
  final FocusNode _costFocus = FocusNode();
  final FocusNode _customerFocus = FocusNode();
  final FocusNode _issuePriorityFocus = FocusNode();
  final FocusNode _invoiceValueFocus = FocusNode();
  final FocusNode _siteLocationFocus = FocusNode();
  final FocusNode _epcContractorFocus = FocusNode();
  final FocusNode _equipmentRatingFocus = FocusNode();
  final FocusNode _imageAttachmentFocus = FocusNode();
  final FocusNode _customerConcernsFocus = FocusNode();
  final FocusNode _numManDaysAtSiteFocus = FocusNode();
  final FocusNode _resourceAllocationFocus = FocusNode();
  final FocusNode _numDaysResourceIdleFocus = FocusNode();
  final FocusNode _manufacturerConcernsFocus = FocusNode();
  final FocusNode _multipleVisitReasonsFocus = FocusNode();
  final FocusNode _resourceRequirementsFocus = FocusNode();
  final FocusNode _expectedManDaysAtSiteFocus = FocusNode();
  final FocusNode _distanceFromPreviousJobFocus = FocusNode();
  final FocusNode _manufacturerServiceCostFocus = FocusNode();
  final FocusNode _resourceCompanyEarningsFocus = FocusNode();
  final FocusNode _attachmentBillOfQuantityFocus = FocusNode();
  final FocusNode _attachmentProjectSectionFocus = FocusNode();
  final FocusNode _numDaysSinceBillSubmissionFocus = FocusNode();
  final FocusNode _resourceCompanyExpenditureFocus = FocusNode();
  final FocusNode _attachmentQuotationRevisionsFocus = FocusNode();
  final FocusNode _serviceCostAgainstInvoiceValueFocus = FocusNode();
  final FocusNode _receivablesAgainstPurchaseOrderFocus = FocusNode();
  final FocusNode _attachmentTechnicalSpecificationFocus = FocusNode();
  final FocusNode _attachmentClarificationsFromCustomerFocus = FocusNode();

  final FocusNode _tnsFocus = FocusNode();

  _handleSubmit() {
    _saveButtonTapped = true;
    setState(() => _buttonText = 'WRITING TO DATABASE');
    if (_fbKey.currentState!.saveAndValidate()) {
      StorageApi().writeDataToCloudFireStore({
        'epcContractor': _fbKey.currentState!.value['epc_contractor'] as String,
        'customer': _fbKey.currentState!.value['customer'] as String,
        'siteLocation': _fbKey.currentState!.value['site_location'] as String,
        'equipmentRating':
            _fbKey.currentState!.value['equipment_rating'] as double,
        'issuePriority': _fbKey.currentState!.value['issue_priority'] as String,
        'cost': _fbKey.currentState!.value['cost'] as double,
        'resourceRequirements':
            _fbKey.currentState!.value['resource_requirements'] as String,
        'invoiceValue': _fbKey.currentState!.value['invoiceValue'] as int,
        'customerConcerns':
            _fbKey.currentState!.value['customerConcerns'] as String,
        'numManDaysAtSite':
            _fbKey.currentState!.value['numManDaysAtSite'] as int,
        'resourceAllocation':
            _fbKey.currentState!.value['resourceAllocation'] as int,
        'numDaysResourceIdle':
            _fbKey.currentState!.value['numDaysResourceIdle'] as int,
        'manufacturerConcerns':
            _fbKey.currentState!.value['manufacturerConcerns'] as String,
        'multipleVisitReasons':
            _fbKey.currentState!.value['multipleVisitReasons'] as String,
        'expectedManDaysAtSite':
            _fbKey.currentState!.value['expectedManDaysAtSite'] as int,
        'distanceFromPreviousJob':
            _fbKey.currentState!.value['distanceFromPreviousJob'] as double,
        'manufacturerServiceCost':
            _fbKey.currentState!.value['manufacturerServiceCost'] as double,
        'resourceCompanyEarnings':
            _fbKey.currentState!.value['resourceCompanyEarnings'] as double,
        'attachmentBillOfQuantity':
            _fbKey.currentState!.value['attachmentBillOfQuantity'] as File,
        'attachmentProjectSection':
            _fbKey.currentState!.value['attachmentProjectSection'] as File,
        "numDaysSinceBillSubmission":
            _fbKey.currentState!.value['numDaysSinceBillSubmission'] as int,
        'resourceCompanyExpenditure':
            _fbKey.currentState!.value['resourceCompanyExpenditure'] as double,
        'attachmentQuotationRevisions':
            _fbKey.currentState!.value['attachmentQuotationRevisions'] as File,
        'serviceCostAgainstInvoiceValue': _fbKey
            .currentState!.value['serviceCostAgainstInvoiceValue'] as double,
        'receivablesAgainstPurchaseOrder': _fbKey
            .currentState!.value['receivablesAgainstPurchaseOrder'] as double,
        'attachmentTechnicalSpecification': _fbKey
            .currentState!.value['attachmentTechnicalSpecification'] as File,
        'attachmentClarificationsFromCustomer': _fbKey.currentState!
            .value['attachmentClarificationsFromCustomer'] as File,
        'imageAttachment':
            _fbKey.currentState!.value['imageAttachment'] as File,
      }).then((value) {
        setState(() => _buttonText = 'WRITTEN SUCCESSFULLY');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        FormBuilderFieldOption(
                            value: 'low', child: Text('Low')),
                        FormBuilderFieldOption(
                            value: 'med', child: Text('Med')),
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
                      focusNode: _invoiceValueFocus,
                      name: 'invoiceValue',
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

                    FormBuilderTextField(
                      focusNode: _customerConcernsFocus,
                      decoration:
                          const InputDecoration(labelText: 'Customer Concerns'),
                      name: 'customerConcerns',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 3),
                        FormBuilderValidators.required(context)
                      ]),
                    ),
                    FormBuilderTextField(
                      focusNode: _numManDaysAtSiteFocus,
                      name: 'numManDaysAtSite',
                      decoration: const InputDecoration(
                        labelText: 'Number of Man Days At Site',
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
                      focusNode: _resourceAllocationFocus,
                      name: 'resourceAllocation',
                      decoration: const InputDecoration(
                        labelText: 'Resource Allocation',
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
                      focusNode: _numDaysResourceIdleFocus,
                      name: 'numDaysResourceIdle',
                      decoration: const InputDecoration(
                        labelText: 'Number of Days Resource Idle',
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
                      focusNode: _manufacturerConcernsFocus,
                      decoration: const InputDecoration(
                          labelText: 'Manufacturer Concerns'),
                      name: 'manufacturerConcerns',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 3),
                        FormBuilderValidators.required(context)
                      ]),
                    ),
                    FormBuilderTextField(
                      focusNode: _multipleVisitReasonsFocus,
                      decoration: const InputDecoration(
                          labelText: 'Multiple Visit Reasons '),
                      name: 'multipleVisitReasons',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 3),
                        FormBuilderValidators.required(context)
                      ]),
                    ),
                    FormBuilderTextField(
                      focusNode: _expectedManDaysAtSiteFocus,
                      name: 'expectedManDaysAtSite',
                      decoration: const InputDecoration(
                        labelText: 'Expected Man Days At Site',
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
                      focusNode: _distanceFromPreviousJobFocus,
                      name: 'distanceFromPreviousJob',
                      decoration: const InputDecoration(
                        labelText: 'Distance From Previous Job',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _manufacturerServiceCostFocus,
                      name: 'manufacturerServiceCost',
                      decoration: const InputDecoration(
                        labelText: 'Manufacturer Service Cost',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _resourceCompanyEarningsFocus,
                      name: 'resourceCompanyEarnings',
                      decoration: const InputDecoration(
                        labelText: 'Resource Company Earnings',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _numDaysSinceBillSubmissionFocus,
                      name: 'numDaysSinceBillSubmission',
                      decoration: const InputDecoration(
                        labelText: 'Number of Days Since Bill Submission',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _resourceCompanyExpenditureFocus,
                      name: 'resourceCompanyExpenditure',
                      decoration: const InputDecoration(
                        labelText: 'Resource Company Expenditure',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _serviceCostAgainstInvoiceValueFocus,
                      name: 'serviceCostAgaisntInvoiceValue',
                      decoration: const InputDecoration(
                        labelText: 'Service Cost Against Invoice Value',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderTextField(
                      focusNode: _receivablesAgainstPurchaseOrderFocus,
                      name: 'receivableAgainstPurchaseOrder',
                      decoration: const InputDecoration(
                        labelText: 'Receivables Against Purchase Order',
                      ),
                      valueTransformer: (text) => num.tryParse(text!),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                      keyboardType: TextInputType.number,
                    ),
                    FormBuilderFilePicker(
                      focusNode: _imageAttachmentFocus,
                      name: 'imageAttachment',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
                    ),
                    FormBuilderFilePicker(
                      focusNode: _attachmentBillOfQuantityFocus,
                      name: 'attachmentBillOfQuantity',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
                    ),
                    FormBuilderFilePicker(
                      focusNode: _attachmentProjectSectionFocus,
                      name: 'attachmentProjectSection',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
                    ),
                    FormBuilderFilePicker(
                      focusNode: _attachmentQuotationRevisionsFocus,
                      name: 'attachmentQuotationRevisions',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
                    ),
                    FormBuilderFilePicker(
                      focusNode: _attachmentTechnicalSpecificationFocus,
                      name: 'attachmentTechnicalSpecification',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
                    ),
                    FormBuilderFilePicker(
                      focusNode: _attachmentClarificationsFromCustomerFocus,
                      name: 'attachmentClarificationsFromCustomer',
                      previewImages: false,
                      allowMultiple: false,
                      maxFiles: 1,
                      onFileLoading: (status) =>
                          const CircularProgressIndicator(),
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
                    )
                  ]),
                ),
              ),
            ),
          )),
    );
  }
}
