import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../services/services.dart';
import 'widgets/widgets.dart';

class IssueForm extends StatefulWidget {
  const IssueForm({Key? key}) : super(key: key);

  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssueForm> {
  //Default button state
  // ignore: unused_field
  bool _saveButtonTapped = false;
  String _buttonText = 'SAVE TO GOOGLE CLOUD';
  // Form key
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  // Focus Nodes
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
//Terms of service focus note
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.text,
                            focusNode: _epcContractorFocus,
                            labelText: 'EPC Contractor',
                            name: 'epcContractor'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.text,
                            focusNode: _customerFocus,
                            labelText: 'Customer',
                            name: 'customer'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.text,
                            focusNode: _siteLocationFocus,
                            name: 'siteLocation',
                            labelText: 'Site Location'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.rating,
                            focusNode: _equipmentRatingFocus,
                            labelText: 'Equipment Rating',
                            name: 'equipmentRating'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.choicechip,
                            focusNode: _issuePriorityFocus,
                            labelText: 'Choose Issue Priority',
                            name: 'issuePriority'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.textfield,
                            focusNode: _resourceRequirementsFocus,
                            labelText: 'Resource Requirements',
                            name: 'resourceRequirements'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _costFocus,
                            name: 'cost',
                            labelText: 'Enter Cost'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _invoiceValueFocus,
                            name: 'invoiceValue',
                            labelText: 'Enter Invoice Value'),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.textfield,
                          focusNode: _customerConcernsFocus,
                          name: 'customerConcerns',
                          labelText: 'Customer Concerns',
                        ),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _numManDaysAtSiteFocus,
                            name: 'numManDaysAtSite',
                            labelText: 'Number of Man Days At Site'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _resourceAllocationFocus,
                            name: 'resouceAllocation',
                            labelText: 'Number of resources allocated'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _numDaysResourceIdleFocus,
                            name: 'numDaysResourceIdle',
                            labelText: 'Number of idle days for resource'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.textfield,
                            focusNode: _manufacturerConcernsFocus,
                            name: 'manufacturerConcerns',
                            labelText: 'Manufacturer Concerns'),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.textfield,
                          focusNode: _multipleVisitReasonsFocus,
                          name: 'multipleVisitReasons',
                          labelText: 'Multiple Visit Reasons',
                          maxLines: 4,
                        ),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _expectedManDaysAtSiteFocus,
                            name: 'expectedManDaysAtSite',
                            labelText: 'Expected Man Days At Site'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _distanceFromPreviousJobFocus,
                            name: 'distanceFromPreviousJob',
                            labelText: 'Distance from Previous Job'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _manufacturerServiceCostFocus,
                            name: 'manufacturerServiceCost',
                            labelText: 'Manufacturer Service Cost'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _resourceCompanyEarningsFocus,
                            name: 'resourceCompanyEarningsFocus',
                            labelText: 'Resource Companty Earnings'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _numDaysSinceBillSubmissionFocus,
                            name: 'numDaysSinceBillSubmission',
                            labelText: 'Number of Days Since Bill Submission'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _resourceCompanyExpenditureFocus,
                            name: 'resourceCompanyExpenditureFocus',
                            labelText: 'Resource Company Expenditure'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _serviceCostAgainstInvoiceValueFocus,
                            name: 'serviceCostAgainstInvoiceValueFocus',
                            labelText: 'Service Cost Against Invoice Value'),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.number,
                            focusNode: _receivablesAgainstPurchaseOrderFocus,
                            name: 'receivablesAgainstPurchaseOrderFocus',
                            labelText: 'Receivable Against Purchase Order'),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const Text(
                          'ATTACHMENTS',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _imageAttachmentFocus,
                          name: 'imageAttachment',
                          labelText: 'Image Attachment',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _attachmentBillOfQuantityFocus,
                          name: 'attachmentBillOfQuantity',
                          labelText: 'Attachment Bill Quantity',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _attachmentProjectSectionFocus,
                          name: 'attachmentProjectSectionFocus',
                          labelText: 'Attachment Project Section',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _attachmentQuotationRevisionsFocus,
                          name: 'attachmentQuotationRevisionsFocus',
                          labelText: 'Attachment Quotation Revision',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _attachmentTechnicalSpecificationFocus,
                          name: 'attachmentTechnicalSpecificationFocus',
                          labelText: 'Attachment Technical Specification Focus',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                          fieldType: FieldType.fileupload,
                          focusNode: _attachmentClarificationsFromCustomerFocus,
                          name: 'attachmentClarificationsFromCustomerFocus',
                          labelText: 'Attachment Clarification From Customer',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomFormBuilderFieldHelper(
                            fieldType: FieldType.checkbox,
                            name: 'acceptTerms',
                            focusNode: _tnsFocus),
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
