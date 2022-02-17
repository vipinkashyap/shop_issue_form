import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_issue_form_flutter/constants/custom_file_picker.dart';
import 'package:shop_issue_form_flutter/constants/custom_number_field.dart';
import 'package:shop_issue_form_flutter/constants/custom_text_field.dart';

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
        'epcContractor': _fbKey.currentState!.value['epcContractor'] as String,
        'customer': _fbKey.currentState!.value['customer'] as String,
        'siteLocation': _fbKey.currentState!.value['siteLocation'] as String,
        'equipmentRating':
            _fbKey.currentState!.value['equipmentRating'] as double,
        'issuePriority': _fbKey.currentState!.value['issuePriority'] as String,
        'cost': _fbKey.currentState!.value['cost'] as double,
        'resourceRequirements':
            _fbKey.currentState!.value['resourceRequirements'] as String,
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                              focusNode: _epcContractorFocus,
                              name: 'epcContractor',
                              labelTextName: 'EPC Contractor'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              focusNode: _customerFocus,
                              name: 'customerFocues',
                              labelTextName: 'Customer Focus'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              focusNode: _siteLocationFocus,
                              name: 'siteLocation',
                              labelTextName: 'Site Location'),
                          SizedBox(
                            height: 10,
                          ),
                          FormBuilderRatingBar(
                            focusNode: _equipmentRatingFocus,
                            validator: FormBuilderValidators.required(context),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Equipment Rating'),
                            name: 'equipmentRating',
                            initialValue: 0.0,
                            maxRating: 5.0,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FormBuilderChoiceChip(
                            backgroundColor: Colors.grey[300],
                            selectedColor: Colors.blue[400],
                            elevation: 2,
                            padding: EdgeInsets.all(8),
                            focusNode: _issuePriorityFocus,
                            initialValue: 'low',
                            name: 'issuePriority',
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Choose Issue Priority',
                            ),
                            spacing: 12,
                            options: const [
                              FormBuilderFieldOption(
                                  value: 'low', child: Text('Low')),
                              FormBuilderFieldOption(
                                  value: 'med', child: Text('Med')),
                              FormBuilderFieldOption(
                                  value: 'high', child: Text('High')),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            focusNode: _resourceRequirementsFocus,
                            name: 'resourceRequirements',
                            labelTextName: 'Resource Requirements',
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _costFocus,
                              name: 'cost',
                              labelTextName: 'Enter Cost'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _invoiceValueFocus,
                              name: 'invoiceValue',
                              labelTextName: 'Enter Invoice Value'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            focusNode: _customerConcernsFocus,
                            name: 'customerConcerns',
                            labelTextName: 'Enter Customer Concerns',
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _numManDaysAtSiteFocus,
                              name: 'numManDaysAtSite',
                              labelTextName: 'Number of Man Days At Site'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _resourceAllocationFocus,
                              name: 'resouceAllocation',
                              labelTextName: 'Enter Resource Allocation'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _numDaysResourceIdleFocus,
                              name: 'numDaysResourceIdle',
                              labelTextName: 'Number of Days Resource Idle'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                              focusNode: _manufacturerConcernsFocus,
                              name: 'manufacturerConcerns',
                              labelTextName: 'Enter Manufacturer Concerns'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            focusNode: _multipleVisitReasonsFocus,
                            name: 'multipleVisitReasons',
                            labelTextName: 'Multiple Visit Reasons',
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _expectedManDaysAtSiteFocus,
                              name: 'expectedManDaysAtSite',
                              labelTextName: 'Expected Man Days At Site'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _distanceFromPreviousJobFocus,
                              name: 'distanceFromPreviousJob',
                              labelTextName: 'Distance from Previous Job'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _manufacturerServiceCostFocus,
                              name: 'manufacturerServiceCost',
                              labelTextName: 'Manufacturer Service Cost'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _resourceCompanyEarningsFocus,
                              name: 'resourceCompanyEarningsFocus',
                              labelTextName: 'Resource Companty Earnings'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _numDaysSinceBillSubmissionFocus,
                              name: 'numDaysSinceBillSubmission',
                              labelTextName:
                                  'Number of Days Since Bill Submission'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _resourceCompanyExpenditureFocus,
                              name: 'resourceCompanyExpenditureFocus',
                              labelTextName: 'Resource Company Expenditure'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _serviceCostAgainstInvoiceValueFocus,
                              name: 'serviceCostAgainstInvoiceValueFocus',
                              labelTextName:
                                  'Service Cost Against Invoice Value'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomNumberField(
                              focusName: _receivablesAgainstPurchaseOrderFocus,
                              name: 'receivablesAgainstPurchaseOrderFocus',
                              labelTextName:
                                  'Receivable Against Purchase Order'),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.black,
                          ),
                          Text(
                            'ATTACHMENTS',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomFilePicker(
                            focusNode: _imageAttachmentFocus,
                            name: 'imageAttachment',
                            labelTextName: 'Image Attachment',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFilePicker(
                            focusNode: _attachmentBillOfQuantityFocus,
                            name: 'attachmentBillOfQuantity',
                            labelTextName: 'Attachment Bill Quantity',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFilePicker(
                            focusNode: _attachmentProjectSectionFocus,
                            name: 'attachmentProjectSectionFocus',
                            labelTextName: 'Attachment Project Section',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFilePicker(
                            focusNode: _attachmentQuotationRevisionsFocus,
                            name: 'attachmentQuotationRevisionsFocus',
                            labelTextName: 'Attachment Quotation Revision',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFilePicker(
                            focusNode: _attachmentTechnicalSpecificationFocus,
                            name: 'attachmentTechnicalSpecificationFocus',
                            labelTextName:
                                'Attachment Technical Specification Focus',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomFilePicker(
                            focusNode:
                                _attachmentClarificationsFromCustomerFocus,
                            name: 'attachmentClarificationsFromCustomerFocus',
                            labelTextName:
                                'Attachment Clarification From Customer',
                          ),
                          SizedBox(
                            height: 10,
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
            ),
          )),
    );
  }
}
