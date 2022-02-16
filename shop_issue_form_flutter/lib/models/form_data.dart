import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class IssueForm {
  final String id;
  final double cost;
  final String customer;
  final String issuePriority;
  final double invoiceValue;
  final String siteLocation;
  final String epcContractor;
  final double equipmentRating;
  final File imageAttachment;
  final String customerConcerns;
  final int numManDaysAtSite;
  final int resourceAllocation;
  final int numDaysResourceIdle;
  final String manufacturerConcerns;
  final String multipleVisitReasons;
  final String resourceRequirements;
  final int expectedManDaysAtSite;
  final double distanceFromPreviousJob;
  final double manufacturerServiceCost;
  final double resourceCompanyEarnings;
  final File attachmentBillOfQuantity;
  final File attachmentProjectSection;
  final int numDaysSinceBillSubmission;
  final double resourceCompanyExpenditure;
  final File attachmentQuotationRevisions;
  final double serviceCostAgainstInvoiceValue;
  final double receivablesAgainstPurchaseOrder;
  final File attachmentTechnicalSpecification;
  final File attachmentClarificationsFromCustomer;

  IssueForm({
    String? id,
    required this.cost,
    required this.customer,
    required this.issuePriority,
    required this.invoiceValue,
    required this.siteLocation,
    required this.epcContractor,
    required this.equipmentRating,
    required this.imageAttachment,
    required this.customerConcerns,
    required this.numManDaysAtSite,
    required this.resourceAllocation,
    required this.numDaysResourceIdle,
    required this.manufacturerConcerns,
    required this.multipleVisitReasons,
    required this.resourceRequirements,
    required this.expectedManDaysAtSite,
    required this.distanceFromPreviousJob,
    required this.manufacturerServiceCost,
    required this.resourceCompanyEarnings,
    required this.attachmentBillOfQuantity,
    required this.attachmentProjectSection,
    required this.numDaysSinceBillSubmission,
    required this.resourceCompanyExpenditure,
    required this.attachmentQuotationRevisions,
    double? serviceCostAgainstInvoiceValue,
    required this.receivablesAgainstPurchaseOrder,
    required this.attachmentTechnicalSpecification,
    required this.attachmentClarificationsFromCustomer,
  })  : assert(id == null || id.isNotEmpty,
            'id cannot be null and should be empty'),
        id = id ?? _uuid.v4(),
        serviceCostAgainstInvoiceValue =
            serviceCostAgainstInvoiceValue ?? cost / invoiceValue;
}

class IssueList extends StateNotifier<List<IssueForm>> {
  IssueList(List<IssueForm>? initialIssues) : super(initialIssues ?? []);

  void add({
    String? id,
    bool? isCompleted,
    double? cost,
    String? customer,
    String? issuePriority,
    double? invoiceValue,
    String? siteLocation,
    String? epcContractor,
    double? equipmentRating,
    File? imageAttachment,
    String? customerConcerns,
    int? numManDaysAtSite,
    int? resourceAllocation,
    int? numDaysResourceIdle,
    String? manufacturerConcerns,
    String? multipleVisitReasons,
    String? resourceRequirements,
    int? expectedManDaysAtSite,
    double? distanceFromPreviousJob,
    double? manufacturerServiceCost,
    double? resourceCompanyEarnings,
    File? attachmentBillOfQuantity,
    File? attachmentProjectSection,
    int? numDaysSinceBillSubmission,
    double? resourceCompanyExpenditure,
    File? attachmentQuotationRevisions,
    double? serviceCostAgainstInvoiceValue,
    double? receivablesAgainstPurchaseOrder,
    File? attachmentTechnicalSpecification,
    File? attachmentClarificationsFromCustomer,
  }) {
    [
      ...state,
      IssueForm(
        cost: cost ?? 0.0,
        customer: customer ?? '',
        issuePriority: issuePriority ?? '',
        invoiceValue: invoiceValue ?? 0.0,
        siteLocation: siteLocation ?? '',
        epcContractor: epcContractor ?? '',
        equipmentRating: equipmentRating ?? 0.0,
        imageAttachment: imageAttachment ?? File(''),
        customerConcerns: customerConcerns ?? '',
        numManDaysAtSite: numManDaysAtSite ?? 0,
        resourceAllocation: resourceAllocation ?? 0,
        numDaysResourceIdle: numDaysResourceIdle ?? 0,
        manufacturerConcerns: manufacturerConcerns ?? '',
        multipleVisitReasons: multipleVisitReasons ?? '',
        resourceRequirements: resourceRequirements ?? '',
        expectedManDaysAtSite: expectedManDaysAtSite ?? 0,
        distanceFromPreviousJob: distanceFromPreviousJob ?? 0.0,
        manufacturerServiceCost: manufacturerServiceCost ?? 0.0,
        resourceCompanyEarnings: resourceCompanyEarnings ?? 0.0,
        attachmentBillOfQuantity: attachmentBillOfQuantity ?? File(''),
        attachmentProjectSection: attachmentProjectSection ?? File(''),
        numDaysSinceBillSubmission: numDaysSinceBillSubmission ?? 0,
        resourceCompanyExpenditure: resourceCompanyExpenditure ?? 0.0,
        attachmentQuotationRevisions: attachmentQuotationRevisions ?? File(''),
        serviceCostAgainstInvoiceValue: serviceCostAgainstInvoiceValue,
        receivablesAgainstPurchaseOrder: receivablesAgainstPurchaseOrder ?? 0.0,
        attachmentTechnicalSpecification:
            attachmentTechnicalSpecification ?? File(''),
        attachmentClarificationsFromCustomer:
            attachmentClarificationsFromCustomer ?? File(''),
      ),
    ];
  }

  void edit({
    required String? id,
    required bool? isCompleted,
    required double? cost,
    required String? customer,
    required String? issuePriority,
    required double? invoiceValue,
    required String? siteLocation,
    required String? epcContractor,
    required double? equipmentRating,
    required File? imageAttachment,
    required String? customerConcerns,
    required int? numManDaysAtSite,
    required int? resourceAllocation,
    required int? numDaysResourceIdle,
    required String? manufacturerConcerns,
    required String? multipleVisitReasons,
    required String? resourceRequirements,
    required int? expectedManDaysAtSite,
    required double? distanceFromPreviousJob,
    required double? manufacturerServiceCost,
    required double? resourceCompanyEarnings,
    required File? attachmentBillOfQuantity,
    required File? attachmentProjectSection,
    required int? numDaysSinceBillSubmission,
    required double? resourceCompanyExpenditure,
    required File? attachmentQuotationRevisions,
    required double? serviceCostAgainstInvoiceValue,
    required double? receivablesAgainstPurchaseOrder,
    required File? attachmentTechnicalSpecification,
    required File? attachmentClarificationsFromCustomer,
  }) {
    state = [
      for (final issue in state)
        if (issue.id == id)
          IssueForm(
              cost: issue.cost,
              customer: issue.customer,
              issuePriority: issue.issuePriority,
              invoiceValue: issue.invoiceValue,
              siteLocation: issue.siteLocation,
              epcContractor: issue.epcContractor,
              equipmentRating: issue.equipmentRating,
              imageAttachment: issue.imageAttachment,
              customerConcerns: issue.customerConcerns,
              numManDaysAtSite: issue.numManDaysAtSite,
              resourceAllocation: issue.resourceAllocation,
              numDaysResourceIdle: issue.numDaysResourceIdle,
              manufacturerConcerns: issue.manufacturerConcerns,
              multipleVisitReasons: issue.multipleVisitReasons,
              resourceRequirements: issue.resourceRequirements,
              expectedManDaysAtSite: issue.expectedManDaysAtSite,
              distanceFromPreviousJob: issue.distanceFromPreviousJob,
              manufacturerServiceCost: issue.manufacturerServiceCost,
              resourceCompanyEarnings: issue.resourceCompanyEarnings,
              attachmentBillOfQuantity: issue.attachmentBillOfQuantity,
              attachmentProjectSection: issue.attachmentProjectSection,
              numDaysSinceBillSubmission: issue.numDaysSinceBillSubmission,
              resourceCompanyExpenditure: issue.resourceCompanyExpenditure,
              attachmentQuotationRevisions: issue.attachmentQuotationRevisions,
              receivablesAgainstPurchaseOrder:
                  issue.receivablesAgainstPurchaseOrder,
              attachmentTechnicalSpecification:
                  issue.attachmentTechnicalSpecification,
              attachmentClarificationsFromCustomer:
                  issue.attachmentClarificationsFromCustomer)
        else
          issue,
    ];
  }

  void remove(IssueForm target) {
    state = state.where((issue) => issue.id != target.id).toList();
  }
}
