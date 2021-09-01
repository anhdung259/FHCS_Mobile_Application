import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_treament_info_request/insert_treament_info_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_medicine_inventory_detail/response_medicine_inventory_detail.dart';
import 'package:fhcs_mobile_application/data/model/response/response_treatment_info_detail/response_treatment_info_detail.dart';
import 'package:fhcs_mobile_application/data/model/treatmentInfo/treatment_info.dart';
import 'package:fhcs_mobile_application/data/model/treatment_info_result_search/treatment_info_result_search.dart';
import 'package:fhcs_mobile_application/data/model/treatment_information_details/treatment_information_details.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/data/repository/treatment_repository.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/filter_treatment_info/filter_treatment_info.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/choice_medicine.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/filter_choice_medicine.dart';
import 'package:fhcs_mobile_application/screens/ManageTreatmentInfo/insert_treatment_info/components/update_choice_medicine_inventory.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import 'package:uuid/uuid.dart';

class TreatmentInfoController extends GetxController {
  final TreatmentInfoRepository repository;
  TreatmentInfoController({@required this.repository})
      : assert(repository != null);
  var medicineInventory = MedicineInventoryResultSearch().obs;
  var listPaginationTreament =
      List<TreatmentInfoResultSearch>.empty(growable: true).obs;
  var listPaginationMedicineChoice =
      List<MedicineInventoryResultSearch>.empty(growable: true).obs;
  var listRecently = <TreatmentInfoResultSearch>[].obs;
  var medicineInventorySearchList = <MedicineInventoryResultSearch>[].obs;

  var listMedicineInventorySelected = <TreatmentInfoDetail>[];
  var listPrescriptionDetails = <TreatmentInfoDetail>[].obs;
  var listPrescriptionDetailsUpdate = <TreatmentInfoDetail>[].obs;
  var listPrescription = <TreatmentInfo>[].obs;
  var listUpdate = <MedicineInventoryResultSearch>[].obs;
  var treatmentInformationDetail = TreatmentInfoDetailResponse().obs;

  var listDepartment = <Department>[].obs;
  var statusTreatmentInfo = ["Đã xác nhận", "Chưa xác nhận"];
  var patientDetail = Patient().obs;
  var listDiagnosticSelected = <Diagnostic>[];
  var listAllergySelected = <Allergy>[];
  var listDiagnosticFliter = <Diagnostic>[];
  var listAllergyFliter = <Allergy>[];
  var medicineId = "";
  var isLoading = true.obs;
  var isLoadingRecent = true.obs;
  var isFound = true.obs;
  var isFoundChoiceMedicince = true.obs;
  var isMoreTreatmentInfoAvailable = true.obs;
  var isMoreDataMedicineAvailable = true.obs;
  var currentPage = 1;
  var pageSize = 10;
  var month = 1;
  var year = 0;
  var pagingloading = false.obs;
  var info = Info().obs;
  var medicineInventoryId = "";
  var totalMedicineSelected = 0.obs;
  var prescriptionId = "";
  var treatmentId = "";
  var medicineNameWarning = "";
  bool showWarningQuantity = false;
  var pushBottom = false.obs;
  var uuid = Uuid();
  TextEditingController textSearchTreatmentInfoController =
      TextEditingController();
  TextEditingController textSearchMedicineController = TextEditingController();
  TextEditingController textCodePatientController = TextEditingController();
  TextEditingController textNamePatientController = TextEditingController();
  TextEditingController textDiseaseStatusPatientController =
      TextEditingController();
  TextEditingController textNewDepartmentController = TextEditingController();

  TextEditingController textIcdCodeController = TextEditingController();
  TextEditingController textNameDiagnosticController = TextEditingController();
  TextEditingController textDescriptionDiagnosticController =
      TextEditingController();

  TextEditingController textPeriodicMonthFilterController =
      TextEditingController();
  TextEditingController textPeriodicYearFilterController =
      TextEditingController();
  var departmentId = "".obs;
  var listDiagnosticDisplay = "".obs;
  var listAllergyDisplay = "".obs;
  var fromDateFilter = "";
  var toDateFilter = "";
  var departmentFilter = "".obs;
  var genderFilter = "".obs;
  var isDeliveredFilter = "".obs;
  var medicineSubGroupIdFilter = "".obs;
  var medicineClassificationsIdFilter = "".obs;
  var genderSelect = "M".obs;
  var isDelivered = false;
  var showRemove = false;
  var showEdit = false;
  var loadingWait = false.obs;
  List<String> gender = ["M", "F"];
  Map<String, ValueCompare> searchValueMedicineInventory = {};
  Map<String, ValueCompare> searchValueMedicineInventoryDetail = {};
  Map<String, ValueCompare> searchValueDepartment = {};
  Map<String, ValueCompare> searchValueTreatmentInfo = {};
  Map<String, ValueCompare> searchValueTreatmentInfoRecent = {};
  List<TextEditingController> indicationToDrinkController = [];
  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  SettingController sc = Get.put(SettingController(
      repository: SettingRepository(apiClient: ApiProvider())));

  var createNew = false;
  @override
  void onInit() {
    getTimeNow();
    fetchDepartmentList("");
    super.onInit();
  }

  Future<bool> backScreen() {
    GeneralHelper.showConfirmBackScreenInput(function: cleanData);
    return Future.value(false);
  }

  void refreshList() async {
    resetTextFilter();
    fetchTreatmentInfo();
  }

  void refreshListChoiceMedicine() async {
    resetFilterChoiceMedicine();
    fetchMedicineChoice();
  }

  void getTimeNow() {
    DateTime now = new DateTime.now();
    month = now.month;
    year = now.year;
  }
//fetch treatmentInfo

  void paginateList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listPaginationTreament,
        isMoreDataAvailable: isMoreTreatmentInfoAvailable,
        limit: pageSize,
        searchValue: searchValueTreatmentInfo,
        sortField: "createAt",
        sortOrder: 1,
        selectFields:
            "id,createAt, isDelivered, patient.name as patientName, patient.department.name as departmentName",
        searchFuntion: repository.searchTreatmentInfo);
  }

  void updateMapSearchValue() {
    GeneralHelper.updateSearchMap(
        fieldSearch: "patient.name",
        searchMap: searchValueTreatmentInfo,
        valueSearch: textSearchTreatmentInfoController.text,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "patient.gender",
        searchMap: searchValueTreatmentInfo,
        valueSearch: genderFilter.value,
        compare: "Equals");
    GeneralHelper.updateSearchMap(
        fieldSearch: "isDelivered",
        searchMap: searchValueTreatmentInfo,
        valueSearch: isDeliveredFilter.value,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "patient.departmentId",
        searchMap: searchValueTreatmentInfo,
        valueSearch: departmentFilter.value,
        compare: "Equals");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        searchMap: searchValueTreatmentInfo,
        valueSearch: textPeriodicMonthFilterController.text,
        compare: "=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        searchMap: searchValueTreatmentInfo,
        valueSearch: textPeriodicYearFilterController.text,
        compare: "=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "createAt|from",
        searchMap: searchValueTreatmentInfo,
        valueSearch: fromDateFilter,
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "createAt|to",
        searchMap: searchValueTreatmentInfo,
        valueSearch: toDateFilter,
        compare: "<=");
    //filter total price
  }

  void fetchTreatmentInfo() async {
    isLoading(true);
    isMoreTreatmentInfoAvailable(true);
    listPaginationTreament.clear();
    updateMapSearchValue();

    try {
      var result = await repository.searchTreatmentInfo(
        SearchRequest(
            limit: pageSize,
            searchValue: searchValueTreatmentInfo,
            page: 1,
            sortField: "createAt",
            sortOrder: 1,
            selectFields:
                "id,createAt, isDelivered, patient.name as patientName, patient.department.name as departmentName"),
      );
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        listPaginationTreament.addAll(result.data.data);
        if (listPaginationTreament.isEmpty) {
          isFound(false);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchTreatmentInfoRecently() async {
    isLoadingRecent(true);
    try {
      var result = await repository.searchTreatmentInfo(
        SearchRequest(
            limit: LIMIT_RECENTLY,
            //searchValue: searchValueTreatmentInfo,
            page: 1,
            sortField: "createAt",
            sortOrder: 1,
            selectFields:
                "id,createAt, isDelivered, patient.name as patientName, patient.department.name as departmentName"),
      );
      if (result.statusCode == 200) {
        listRecently.value = result.data.data;
        isLoadingRecent(true);
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } finally {
      isLoadingRecent(false);
    }
  }

  resetTextFilter() {
    textSearchTreatmentInfoController.clear();
    departmentFilter.value = "";
    fromDateFilter = "";
    toDateFilter = "";
    isDeliveredFilter.value = "";
    genderFilter.value = "";
  }

  resetFilterChoiceMedicine() {
    listDiagnosticFliter.clear();
    listAllergyFliter.clear();
    medicineClassificationsIdFilter.value = "";
    medicineSubGroupIdFilter.value = "";
  }

  void showDialogFilter() {
    GeneralHelper.showFilterDialog(filter: FilterTreatmentInfo());
  }

  void showDialogFilterChoiceMedicine() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      backgroundColor: Colors.white,
      context: Get.context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[FilterChoiceInfo()],
        ),
      ),
    );
  }

  void getTreatmentDetail() async {
    showWarningQuantity = false;
    listDiagnosticDisplay = "".obs;
    var listDiagnostic = [];
    var listAllergy = [];
    try {
      var result = await repository.getTreatmentInfoDetail(treatmentId);
      if (result.statusCode == 200) {
        treatmentInformationDetail.value = result.data;
        if (treatmentInformationDetail.value.isDelivered == true) {
          showRemove = false;
          showEdit = false;
          getTimeNow();
        } else {
          showRemove = true;
          showEdit = true;
          await warningQuantity();
          month = treatmentInformationDetail.value.month;
          year = treatmentInformationDetail.value.year;
        }
        if (treatmentInformationDetail.value.allergies.isNotEmpty) {
          for (var item in treatmentInformationDetail.value.allergies) {
            listAllergy.add(item.name);
          }
          listAllergyDisplay.value = listAllergy.join(", ");
        } else {
          listAllergyDisplay.value = NOINFO;
        }
        for (var item in treatmentInformationDetail.value.diagnostics) {
          listDiagnostic.add(item.name);
        }
        listDiagnosticDisplay.value = listDiagnostic.join(", ");
        if (createNew == true && Get.currentRoute != "/home") {
          Get.offNamed("/treatmentInfoDetail");
        } else {
          Get.toNamed("/treatmentInfoDetail");
        }
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future warningQuantity() async {
    var listMedicineNameWarning = [];
    for (var item in treatmentInformationDetail.value.treatmentInformations) {
      for (var item2 in item.treatmentInformationDetails) {
        await checkQuantityAvaiablePrescription(
                item2.medicineInInventoryDetailId)
            .then((value) {
          if (item2.quantity > value) {
            showWarningQuantity = true;
            listMedicineNameWarning.add(item.medicine.name);
            print(item.medicine.name);
          }
        });
      }
    }
    medicineNameWarning = listMedicineNameWarning.join(", ");
  }

  Future<int> checkQuantityAvaiablePrescription(
      String medicineInventoryDetailId) async {
    var result =
        await repository.checkQuanityAvaiable(medicineInventoryDetailId);
    int quantityAvaiable = 0;
    MedicineInventoryDetailResponse medicineInventoryDetail;
    if (result.statusCode == 200) {
      medicineInventoryDetail = result.data;
      quantityAvaiable = medicineInventoryDetail.quantity;
      // print(medicineInventoryDetail.quantity);

    } else {
      GeneralHelper.showMessage(msg: result.message);
    }
    return quantityAvaiable;
  }

  void navigatorUpdateTreatmentDetail() async {
    listAllergySelected.clear();
    listDiagnosticSelected.clear();
    listDiagnosticFliter.clear();
    listAllergyFliter.clear();
    fetchDepartmentList("");
    var listPrescriptionUpdate = <TreatmentInfo>[];
    var listGetPrescriptionDetailUpdate = <TreatmentInfoDetail>[];

    textCodePatientController.text =
        treatmentInformationDetail.value.patient.internalCode;
    textNamePatientController.text =
        treatmentInformationDetail.value.patient.name;
    textDiseaseStatusPatientController.text =
        treatmentInformationDetail.value.diseaseStatuses;
    genderSelect.value = treatmentInformationDetail.value.patient.gender;
    listAllergySelected.addAll(treatmentInformationDetail.value.allergies);
    listDiagnosticSelected.addAll(treatmentInformationDetail.value.diagnostics);
    // listDiagnosticFliter.addAll(listDiagnosticSelected);
    // listAllergyFliter.addAll(listAllergySelected);
    for (var item in treatmentInformationDetail.value.treatmentInformations) {
      listPrescriptionUpdate.add(new TreatmentInfo(
          nameMedicine: item.medicine.name,
          unitMedicine: item.medicine.medicineUnit.name,
          medicineId: item.medicine.id,
          quantity: item.quantity,
          indicationToDrink: item.indicationToDrink));
    }
    for (var item in treatmentInformationDetail.value.treatmentInformations) {
      listGetPrescriptionDetailUpdate.addAll(item.treatmentInformationDetails);
    }
    for (var item in listGetPrescriptionDetailUpdate) {
      listMedicineInventorySelected.add(
        TreatmentInfoDetail(
            medicineInInventoryDetailId: item.medicineInInventoryDetailId,
            medicineId: item.medicineId,
            medicineName: listPrescriptionUpdate
                .singleWhere((e) => e.medicineId == item.medicineId)
                .nameMedicine,
            unitName: listPrescriptionUpdate
                .singleWhere((e) => e.medicineId == item.medicineId)
                .unitMedicine,
            quantity: item.quantity),
      );
    }

    for (var item in listGetPrescriptionDetailUpdate) {
      listPrescriptionDetails.add(
        TreatmentInfoDetail(
          medicineInInventoryDetailId: item.medicineInInventoryDetailId,
          medicineId: item.medicineId,
          medicineName: listPrescriptionUpdate
              .singleWhere((e) => e.medicineId == item.medicineId)
              .nameMedicine,
          unitName: listPrescriptionUpdate
              .singleWhere((e) => e.medicineId == item.medicineId)
              .unitMedicine,
          quantity: item.quantity,
        ),
      );
    }
    listPrescription.value = listPrescriptionUpdate;
    indicationToDrinkController = List.generate(
        listPrescription.length,
        (i) => TextEditingController(
            text: listPrescriptionUpdate[i].indicationToDrink));
    departmentId.value = treatmentInformationDetail.value.patient.departmentId;
    await checkSelectMedicine();

    Get.toNamed("/insertTreatmentInfo");
  }

  void paginateMedicineChoiceList() async {
    GeneralHelper.paging(
        info: info,
        listPagination: listPaginationMedicineChoice,
        isMoreDataAvailable: isMoreDataMedicineAvailable,
        limit: 12,
        searchValue: searchValueMedicineInventory,
        includes: ["Medicine", "Medicine.MedicineUnit", "PeriodicInventory"],
        groupBys: [
          "Medicine.Id as MedicineId",
          "Medicine.Name as Name",
          "Medicine.MedicineUnit.Name as UnitName",
          "PeriodicInventoryId"
        ],
        allergyIds: listAllergyFliter.map((e) => e.id).toList(),
        diagnosticIds: listDiagnosticFliter.map((e) => e.id).toList(),
        sortField: "Quantity",
        sortOrder: 0,
        selectFields: "MedicineId,Name,UnitName,Sum(Quantity) as Quantity",
        searchFuntion: repository.searchMedicineInventories);
  }

  Future checkSelectMedicine() async {
    for (var item in listPrescription) {
      await fetchMedicineInventoryDetail(item.medicineId).then((value) {
        listUpdate
            .addAll(value.where((a) => listUpdate.every((b) => a.id != b.id)));
      });
    }
    test();
  }

  Future fetchMedicineChoice() async {
    // medicineSearchList.clear();
    isMoreDataMedicineAvailable(true);
    listPaginationMedicineChoice.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "medicine.name",
        compare: "Contains",
        valueSearch: textSearchMedicineController.text,
        searchMap: searchValueMedicineInventory);
    GeneralHelper.updateSearchMap(
        fieldSearch: "quantity",
        compare: ">",
        valueSearch: "0",
        searchMap: searchValueMedicineInventory);
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        compare: "==",
        valueSearch: year.toString(),
        searchMap: searchValueMedicineInventory);

    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        compare: "==",
        valueSearch: month.toString(),
        searchMap: searchValueMedicineInventory);
    GeneralHelper.updateSearchMap(
        fieldSearch: "Medicine.MedicineClassification.Id",
        compare: "Equals",
        valueSearch: medicineClassificationsIdFilter.value,
        searchMap: searchValueMedicineInventory);
    GeneralHelper.updateSearchMap(
        fieldSearch: "Medicine.MedicineSubgroup.Id",
        compare: "Equals",
        valueSearch: medicineSubGroupIdFilter.value,
        searchMap: searchValueMedicineInventory);

    var result = await repository.searchMedicineInventories(SearchRequest(
      limit: 12,
      searchValue: searchValueMedicineInventory,
      page: 1,
      includes: ["Medicine", "Medicine.MedicineUnit", "PeriodicInventory"],
      groupBys: [
        "Medicine.Id as MedicineId",
        "Medicine.Name as Name",
        "Medicine.MedicineUnit.Name as UnitName",
        "PeriodicInventoryId"
      ],
      allergyIds: listAllergyFliter.map((e) => e.id).toList(),
      diagnosticIds: listDiagnosticFliter.map((e) => e.id).toList(),
      sortField: "Quantity",
      sortOrder: 0,
      selectFields: "MedicineId,Name,UnitName,Sum(Quantity) as Quantity",
    ));

    if (result.statusCode == 200) {
      listPaginationMedicineChoice.addAll(result.data.data);

      isFoundChoiceMedicince(true);
      info.value = result.data.info;
      if (listPaginationMedicineChoice.isEmpty) {
        isFoundChoiceMedicince(false);
      }

      for (var item in listUpdate) {
        print("listUpdate" + item.medicineId + "|" + item.quantity.toString());
      }
    } else {
      GeneralHelper.showMessage(msg: result.message);
    }
  }

  getTotalMedicineSelected() {
    totalMedicineSelected.value = listPrescriptionDetailsUpdate.fold(
        0, (sum, item) => sum + item.quantity);
  }

  Future<List<MedicineInventoryResultSearch>> fetchMedicineInventoryDetail(
      String id) async {
    var list = <MedicineInventoryResultSearch>[];
    GeneralHelper.updateSearchMap(
        fieldSearch: "quantity",
        compare: ">",
        valueSearch: "0",
        searchMap: searchValueMedicineInventoryDetail);
    GeneralHelper.updateSearchMap(
        fieldSearch: "medicineId",
        compare: "Equals",
        valueSearch: id,
        searchMap: searchValueMedicineInventoryDetail);

    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        compare: "==",
        valueSearch: year.toString(),
        searchMap: searchValueMedicineInventoryDetail);

    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        compare: "==",
        valueSearch: month.toString(),
        searchMap: searchValueMedicineInventoryDetail);

    try {
      var result = await repository.searchMedicineInventoryDetail(
        SearchRequest(
            limit: 5,
            searchValue: searchValueMedicineInventoryDetail,
            page: 0,
            sortField: "importMedicine.ExpirationDate",
            sortOrder: 0,
            selectFields:
                "id,medicineId,medicine.Name,quantity,importMedicine.ExpirationDate,medicine.medicineUnit.name as unitName,importMedicine.Price"),
      );
      if (result.statusCode == 200) {
        list = result.data.data;
        List<MedicineInventoryResultSearch> groups = [];
        list.sort((a, b) => a.quantity.compareTo(b.quantity));
        for (var item in list) {
          bool groupExists = false;

          for (MedicineInventoryResultSearch group in groups) {
            if (group.expirationDate == item.expirationDate &&
                group.price == item.price) {
              group.groupByCheck = true;
              if (group.groupByChoiceMedicine == null) {
                group.groupByChoiceMedicine = [];
                group.groupByChoiceMedicine.add(new GroupByChoiceMedicine(
                    medicineInventoryId: group.id, quantity: group.quantity));
              }
              group.groupByChoiceMedicine.add(new GroupByChoiceMedicine(
                  medicineInventoryId: item.id, quantity: item.quantity));
              //   print(group.expirationDate + list[i].expirationDate);
              group.quantity += item.quantity;

              groupExists = true;
            }
          }
          if (!groupExists) {
            groups.add(item);
          }
        }
        groups.sort((a, b) => DateTime.parse(a.expirationDate)
            .compareTo(DateTime.parse(b.expirationDate)));
        medicineInventorySearchList.value = groups;
        return groups;
      } else {
        return [];
      }
    } on Exception catch (e) {
      print(e);
    }
    return list;
  }

  void showMultiSelect() async {
    test();
    await fetchMedicineChoice().then((value) {
      Get.dialog(ChoiceMedicinePrescription());
    });
  }

  bool validateChoice() {
    if (listMedicineInventorySelected
            .where((e) => e.quantity == 0)
            .toList()
            .length >
        0) {
      test();
      GeneralHelper.showMessage(msg: "Chọn lô và nhập số lượng");
      return false;
    }
    return true;
  }

  int sum(List<TreatmentInfoDetail> s) {
    int quantity = 0;
    quantity =
        s.fold(0, (previousValue, element) => previousValue + element.quantity);
    return quantity;
  }

  getGroupedTreatmentDetailsQuantity(
      List<GroupByChoiceMedicine> listGroupCheck) {
    var total = 0;
    if (this.listPrescriptionDetails.length == 0) {
      return total;
    } else {
      for (var itemCheckGroup in listGroupCheck) {
        for (var itemPresDetail in listPrescriptionDetails) {
          if (itemCheckGroup.medicineInventoryId ==
              itemPresDetail.medicineInInventoryDetailId) {
            total += itemPresDetail.quantity;
          }
        }
      }
    }
    return total;
  }

  bool validateUpdateChoice() {
    if (listPrescriptionDetailsUpdate
                .where((e) => e.quantity == 0)
                .toList()
                .length >
            0 ||
        listPrescriptionDetailsUpdate.isEmpty) {
      test();
      GeneralHelper.showMessage(msg: "Chọn lô và nhập số lượng");
      return false;
    }
    return true;
  }

  List<GroupByChoiceMedicine> createNewGroupMedicine(
      List<GroupByChoiceMedicine> listGroup) {
    var list = <GroupByChoiceMedicine>[];
    for (var item in listGroup) {
      list.add(new GroupByChoiceMedicine(
          medicineInventoryId: item.medicineInventoryId,
          quantity: item.quantity));
    }
    return list;
  }

  void addToPrescription() async {
    var listSubGroupBy = <TreatmentInfoDetail>[];
    test();
    if (validateChoice()) {
      var listCurrent = <TreatmentInfoDetail>[];
      for (var item in listMedicineInventorySelected) {
        listCurrent.add(
          new TreatmentInfoDetail(
              medicineInInventoryDetailId: item.medicineInInventoryDetailId,
              medicineId: item.medicineId,
              groupByCheck: item.groupByCheck,
              groupByChoiceMedicine: item.groupByChoiceMedicine == null
                  ? []
                  : createNewGroupMedicine(item.groupByChoiceMedicine),
              medicineName: item.medicineName,
              unitName: item.unitName,
              quantity: item.quantity),
        );
      }
      for (var itemAr in listCurrent) {
        if (itemAr.groupByCheck == true &&
            itemAr.groupByChoiceMedicine != null) {
          var list = [];
          for (var item in itemAr.groupByChoiceMedicine) {
            list.add(item);
          }
          list.sort((a, b) => a.quantity.compareTo(b.quantity));
          var sum = 0;
          var quantityStart = itemAr.quantity;
          for (int i = 0; i < list.length; i++) {
            if (itemAr.quantity >= list[i].quantity) {
              itemAr.quantity -= list[i].quantity;
            } else {
              if (sum < quantityStart) {
                list[i].quantity = itemAr.quantity;
              }
            }
            sum += list[i].quantity;
            if (sum <= quantityStart) {
              listSubGroupBy.add(new TreatmentInfoDetail(
                  medicineId: itemAr.medicineId,
                  medicineInInventoryDetailId: list[i].medicineInventoryId,
                  medicineName: itemAr.medicineName,
                  quantity: list[i].quantity,
                  unitName: itemAr.unitName,
                  groupByCheck: true));
            }
          }
        } else {
          listSubGroupBy.add(new TreatmentInfoDetail(
              medicineId: itemAr.medicineId,
              medicineInInventoryDetailId: itemAr.medicineInInventoryDetailId,
              medicineName: itemAr.medicineName,
              quantity: itemAr.quantity,
              unitName: itemAr.unitName,
              groupByCheck: false));
        }
      }

      listPrescriptionDetails.clear();
      listPrescriptionDetails.addAll(listSubGroupBy);
      //test();
      var result = <TreatmentInfo>[];
      for (var item in listPrescriptionDetails) {
        var found = false;
        for (var selected in result) {
          if (selected.medicineId == item.medicineId) {
            found = true;
            selected.quantity += item.quantity;
          }
        }
        if (!found) {
          result.add(new TreatmentInfo(
            id: uuid.v1(),
            medicineId: item.medicineId,
            nameMedicine: item.medicineName,
            unitMedicine: item.unitName,
            quantity: item.quantity,
            indicationToDrink: listPrescription
                    .where((e) => e.medicineId == item.medicineId)
                    .isNotEmpty
                ? listPrescription
                    .singleWhere((e) => e.medicineId == item.medicineId)
                    .indicationToDrink
                : "",
          ));
        }
      }
      for (var item in result) {
        print("result: " +
            item.nameMedicine +
            "|" +
            item.medicineId +
            "|" +
            item.quantity.toString());
      }
      listPrescription.clear();
      listPrescription.addAll(result.where(
          (a) => listPrescription.every((b) => a.medicineId != b.medicineId)));

      indicationToDrinkController = List.generate(
          listPrescription.length,
          (i) => TextEditingController(
              text: listPrescription[i].indicationToDrink));
      // listMedicineInventorySelected.clear();
      //  listPrescription.add()
      await checkSelectMedicine();
      Get.back();
      test();
    }
    // test();
  }

  void showMultiSelectUpdate(String medicineId) async {
    fetchMedicineInventoryDetail(medicineId).then((value) {
      listPrescriptionDetailsUpdate.clear();
      // totalMedicineSelected.value = 0;
      for (var item in listMedicineInventorySelected) {
        if (item.medicineId == medicineId) {
          listPrescriptionDetailsUpdate.add(
            new TreatmentInfoDetail(
                medicineInInventoryDetailId: item.medicineInInventoryDetailId,
                medicineId: item.medicineId,
                groupByCheck: item.groupByCheck,
                groupByChoiceMedicine: item.groupByChoiceMedicine == null
                    ? []
                    : createNewGroupMedicine(item.groupByChoiceMedicine),
                medicineName: item.medicineName,
                unitName: item.unitName,
                quantity: item.quantity),
          );
        }
      }
      for (var item in listPrescriptionDetailsUpdate) {
        print("listPrescriptionDetailsUpdate: " +
            item.medicineInInventoryDetailId +
            "|" +
            item.medicineId +
            "|" +
            item.quantity.toString());
      }

      getTotalMedicineSelected();
      Get.dialog(UpdateChoiceMedicineInventory());
    });
  }

  updatePrescription() {
    if (validateUpdateChoice()) {
      //listPrescriptionDetails.clear();
      var listSubGroupBy = <TreatmentInfoDetail>[];
      var listCurrent = <TreatmentInfoDetail>[];
      for (var item in listPrescriptionDetailsUpdate) {
        listCurrent.add(
          new TreatmentInfoDetail(
              medicineInInventoryDetailId: item.medicineInInventoryDetailId,
              medicineId: item.medicineId,
              groupByCheck: item.groupByCheck,
              groupByChoiceMedicine: item.groupByChoiceMedicine == null
                  ? []
                  : createNewGroupMedicine(item.groupByChoiceMedicine),
              medicineName: item.medicineName,
              unitName: item.unitName,
              quantity: item.quantity),
        );
      }
      for (var itemAr in listCurrent) {
        if (itemAr.groupByCheck == true &&
            itemAr.groupByChoiceMedicine != null) {
          var list = [];
          for (var item in itemAr.groupByChoiceMedicine) {
            list.add(item);
          }
          list.sort((a, b) => a.quantity.compareTo(b.quantity));
          var sum = 0;
          var quantityStart = itemAr.quantity;
          for (int i = 0; i < list.length; i++) {
            if (itemAr.quantity >= list[i].quantity) {
              itemAr.quantity -= list[i].quantity;
            } else {
              if (sum < quantityStart) {
                list[i].quantity = itemAr.quantity;
              }
            }
            sum += list[i].quantity;
            if (sum <= quantityStart) {
              listSubGroupBy.add(new TreatmentInfoDetail(
                  medicineId: itemAr.medicineId,
                  medicineInInventoryDetailId: list[i].medicineInventoryId,
                  medicineName: itemAr.medicineName,
                  quantity: list[i].quantity,
                  unitName: itemAr.unitName,
                  groupByCheck: true));
            }
          }
        } else {
          listSubGroupBy.add(new TreatmentInfoDetail(
              medicineId: itemAr.medicineId,
              medicineInInventoryDetailId: itemAr.medicineInInventoryDetailId,
              medicineName: itemAr.medicineName,
              quantity: itemAr.quantity,
              unitName: itemAr.unitName,
              groupByCheck: false));
        }
      }
      listPrescriptionDetails.removeWhere((e) => e.medicineId == medicineId);

      listPrescriptionDetails.addAll(listSubGroupBy);
      listMedicineInventorySelected.addAll(listSubGroupBy.where((a) =>
          listMedicineInventorySelected.every((b) =>
              a.medicineInInventoryDetailId != b.medicineInInventoryDetailId)));
      listMedicineInventorySelected.removeWhere((e) =>
          listPrescriptionDetailsUpdate.every((a) =>
              a.medicineInInventoryDetailId != e.medicineInInventoryDetailId &&
              a.medicineId == e.medicineId));
      getTotalMedicineSelected();
      listPrescription.singleWhere((e) => e.medicineId == medicineId).quantity =
          totalMedicineSelected.value;
      listPrescription.refresh();
      for (var item in listPrescriptionDetailsUpdate) {
        print(
            item.medicineInInventoryDetailId + "|" + item.quantity.toString());
      }
      test();
      Get.back();
    }
  }

  test() {
    for (var item in listMedicineInventorySelected) {
      print("select: " +
          item.medicineName +
          "|" +
          item.unitName +
          "|" +
          item.medicineInInventoryDetailId +
          "|" +
          item.medicineId +
          "|" +
          item.quantity.toString());
    }
    for (var item in listPrescriptionDetails) {
      print("listPrescriptionDetails: " +
          item.medicineInInventoryDetailId +
          "|" +
          item.medicineId +
          "|" +
          item.quantity.toString() +
          "|" +
          item.groupByCheck.toString());
    }
    for (var item in listPrescription) {
      print("listPrescription: " +
          item.nameMedicine +
          "|" +
          item.medicineId +
          "|" +
          item.quantity.toString());
    }
  }

  deletePrescription() {
    listPrescription.removeWhere((e) => e.medicineId == medicineId);
    listPrescriptionDetails.removeWhere((e) => e.medicineId == medicineId);
    listMedicineInventorySelected
        .removeWhere((e) => e.medicineId == medicineId);
    listPrescription.refresh();
    test();
  }

  void showConfirmDeletePrescription() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () {
        deletePrescription();
      },
    );
  }

  Future<List<dynamic>> fetchDepartmentList(String valueSearch) async {
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueDepartment,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await repository.fetchDepartment(SearchRequest(
        limit: 1,
        page: 0,
        sortOrder: 0,
        sortField: "Name",
        searchValue: searchValueDepartment,
        selectFields: "Id,Name"));
    // print("aaaaa" + result.data.data);
    if (result.statusCode == 200) {
      listDepartment.value = result.data.data;
      return listDepartment;
      // if (listMedicineSubgroups.isEmpty) {
      //   isFound(false);
      // }
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  void insertNewDepartment() async {
    try {
      var result = await repository
          .insertDepartment(Department(name: textNewDepartmentController.text));
      if (result.statusCode == 201) {
        textNewDepartmentController.clear();
        Get.back();

        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void getDetailPatientByInternalCode(String internalCode) async {
    try {
      var result = await repository.getPatientByInternalCode(internalCode);
      if (result.statusCode == 200) {
        patientDetail.value = result.data;
        textNamePatientController.text = patientDetail.value.name;
        listAllergySelected = patientDetail.value.allergies;
        listAllergyFliter.addAll(listAllergySelected
            .where((a) => listAllergyFliter.every((b) => a.id != b.id)));
        departmentId.value = patientDetail.value.departmentId;
        genderSelect.value = patientDetail.value.gender;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<File> writeToFile(Uint8List data) async {
    var uuid = Uuid();
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/signture${uuid.v1()}.jpg'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  validatePatientInfo() {
    if (textCodePatientController.text.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng nhập mã nhân viên!");
      return false;
    }
    if (textNamePatientController.text.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng nhập tên!");
      return false;
    }

    if (textDiseaseStatusPatientController.text.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng nhập tình trạng bệnh!");
      return false;
    }
    if (listDiagnosticSelected.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng chọn chẩn đoán!");
      return false;
    }
    if (departmentId.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng chọn bộ phận phòng ban!");
      return false;
    }
    return true;
  }

  bool validatePerscription() {
    if (listPrescription
            .where((e) => e.indicationToDrink.isEmpty)
            .toList()
            .length >
        0) {
      GeneralHelper.showMessage(msg: "Vui lòng nhập hướng điều trị!");
      return false;
    }
    if (listPrescription.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng tạo đơn thuốc!");
      return false;
    }
    return true;
  }

  validateInsert() {
    if (signatureController.isEmpty) {
      GeneralHelper.showConfirm(
          title: "Tạo đơn không cần ký xác nhận",
          msg: "",
          textOk: "Xác nhận",
          textCancel: "Hủy",
          pressOk: () {
            insertNewTreatmentInfo();
          },
          pressCancel: () {});
    } else {
      insertNewTreatmentInfo();
    }
  }

  validateUpdate() {
    if (signatureController.isEmpty) {
      updateNewTreatmentInfo(false);
    } else {
      updateNewTreatmentInfo(true);
    }
  }

  updateData() {
    fetchTreatmentInfo();
    signatureController.clear();
    if (sc.valueSettingMain.value == 0) {
      fetchTreatmentInfoRecently();
    }
    if (createNew == false) {
      Get.back();
    }
  }

  cleanData() {
    listDiagnosticFliter.clear();
    listAllergyFliter.clear();
    listAllergySelected.clear();
    textSearchMedicineController.clear();
    listPrescription.clear();
    listUpdate.clear();
    listPrescriptionDetails.clear();
    signatureController.clear();
    listDiagnosticSelected.clear();
    textCodePatientController.clear();
    textNamePatientController.clear();
    textDiseaseStatusPatientController.clear();
    listDiagnosticSelected.clear();
    listPrescriptionDetailsUpdate.clear();
    searchValueMedicineInventory.clear();
    listMedicineInventorySelected.clear();
    departmentId.value = "";
    genderSelect.value = "M";
    isDelivered = false;
    loadingWait(false);
  }

  void insertNewTreatmentInfo() async {
    if (validatePatientInfo() && validatePerscription()) {
      loadingWait(true);
      try {
        File file;
        final Uint8List data = await signatureController.toPngBytes();
        if (data != null) {
          file = await writeToFile(data);
        } else {
          file = null;
        }
        var result =
            await repository.insertTreatmentInfo(InsertTreatmentInfoRequest(
          name: textNamePatientController.text,
          internalCode: textCodePatientController.text,
          departmentId: departmentId.value,
          gender: genderSelect.value,
          allergyIds: listAllergySelected.map((e) => e.id).toList(),
          confirmSignatureImg: file ?? null,
          diseaseStatuses: textDiseaseStatusPatientController.text,
          diagnosticIds: listDiagnosticSelected.map((e) => e.id).toList(),
          treatmentInformationDetails: listPrescriptionDetails,
          treatmentInformations: listPrescription,
          isDelivered: true,
        ));
        if (result.statusCode == 201) {
          loadingWait(false);
          treatmentInformationDetail.value = result.data;
          treatmentId = treatmentInformationDetail.value.id;
          createNew = true;
          updateData();
          cleanData();
          getTreatmentDetail();
        } else {
          loadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        loadingWait(false);
        print(e);
      }
    }
  }

  void updateNewTreatmentInfo(bool confirm) async {
    if (validatePatientInfo() && validatePerscription()) {
      loadingWait(true);
      try {
        File file;
        final Uint8List data = await signatureController.toPngBytes();
        if (data != null) {
          file = await writeToFile(data);
        } else {
          file = null;
        }
        var result = await repository.updateTreatmentInfo(
            InsertTreatmentInfoRequest(
              name: textNamePatientController.text,
              internalCode: textCodePatientController.text,
              departmentId: departmentId.value,
              gender: genderSelect.value,
              allergyIds: listAllergySelected.map((e) => e.id).toList(),
              confirmSignatureImg: file ?? null,
              diseaseStatuses: textDiseaseStatusPatientController.text,
              diagnosticIds: listDiagnosticSelected.map((e) => e.id).toList(),
              treatmentInformationDetails: listPrescriptionDetails,
              treatmentInformations: listPrescription,
              isDelivered: confirm,
            ),
            treatmentId);
        // print("aaaaa" + result.data.data);
        if (result.statusCode == 200) {
          loadingWait(false);
          print("DONE");
          getTreatmentDetail();
          updateData();
          cleanData();
          GeneralHelper.showMessage(msg: "Cập nhật đơn thành công");
        } else {
          loadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        loadingWait(false);
        print(e);
      }
    }
  }

  validateConfirm() {
    if (signatureController.isNotEmpty) {
      confirmTreatment();
    } else {
      GeneralHelper.showConfirm(
          title: "Xác nhận đơn không cần ký",
          msg: "",
          textOk: "Xác nhận",
          textCancel: "Hủy",
          pressOk: () {
            confirmTreatment();
          });
    }
  }

  void confirmTreatment() async {
    var result;
    loadingWait(true);
    if (signatureController.isNotEmpty) {
      final Uint8List data = await signatureController.toPngBytes();
      File file = await writeToFile(data);
      result = await repository.confirmTreatmentInfo(
          InsertTreatmentInfoRequest(confirmSignatureImg: file ?? null),
          treatmentId);
    } else {
      result = await repository.confirmTreatmentInfo(
          InsertTreatmentInfoRequest(confirmSignatureImg: null), treatmentId);
    }
    if (result.statusCode == 200) {
      loadingWait(false);
      showRemove = false;
      getTreatmentDetail();
      updateData();
      GeneralHelper.showMessage(msg: "Đã xác nhận đơn điều trị");
    } else {
      loadingWait(false);
      GeneralHelper.showMessage(msg: result.message);
    }
  }

  void showConfirmRemoveTreatmentInfo() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa đơn cấp phát này?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () {
        removeTreatmentInfo();
      },
    );
  }

  void removeTreatmentInfo() async {
    var result = await repository.deleteTreatmentInfo(treatmentId);
    loadingWait(true);
    try {
      if (result.statusCode == 200) {
        loadingWait(false);
        updateData();
        GeneralHelper.showMessage(msg: "Đã xóa đơn cấp phát");
      } else {
        loadingWait(false);
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
