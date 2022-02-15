import 'package:form_builder_file_picker/form_builder_file_picker.dart';

class FormData {
  final String epcContractor;
  final String customer;
  final String siteLocation;
  final double equipmentRating;
  final String issuePriority;
  final double cost;
  final String resourceRequirements;
  final double invoiceValue;
  final List<PlatformFile> attachments;
  final int resourcesAllocated;
  final double distanceFromPreviousJob;
  final double expectedMandaysAtSite;
  final String customerConcerns;
  final String manufacturerConcerns;
  final String multipleReasonVisits;

  FormData(
      this.epcContractor,
      this.customer,
      this.siteLocation,
      this.equipmentRating,
      this.issuePriority,
      this.cost,
      this.resourceRequirements,
      this.invoiceValue,
      this.attachments,
      this.resourcesAllocated,
      this.distanceFromPreviousJob,
      this.expectedMandaysAtSite,
      this.customerConcerns,
      this.manufacturerConcerns,
      this.multipleReasonVisits);
}
