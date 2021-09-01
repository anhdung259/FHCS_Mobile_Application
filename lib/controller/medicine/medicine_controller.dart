import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/medicine/medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/data/model/medicine_export_import_inventory/medicine_export_import_inventory.dart';
import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_medicine_request/insert_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicine/filter_medicine/filter_medicine_dialog.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicine/insertContraindication/insert_contraindication.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MedicineController extends GetxController {
  final MedicineRepository repository;
  MedicineController({@required this.repository}) : assert(repository != null);
  //list
  var listMedicineSubgroups = <MedicineSubgroup>[].obs;
  var listMedicineUnits = <MedicineUnit>[].obs;
  var listMedicineClassifications = <MedicineClassification>[].obs;
  //get detail
  var medicineId = "";
  var medicineDetail = Medicine().obs;
  var medicineSubGroup = MedicineSubgroup().obs;
  var medicineUnit = MedicineUnit().obs;
  var medicineClassification = MedicineClassification().obs;
  //paging
  var info = Info().obs;
  var currentPage = 1;
  var pageSize = 10;
  //loading list
  var isLoading = true.obs;
  var isFound = true.obs;
  var isSuccessful = false.obs;
  var classificationSelected = "".obs;
  var subgroupSelected = "".obs;
  var unitSelected = "".obs;

  var medicineClassificationsId = "".obs;
  var medicineUnitId = "".obs;
  var medicineSubGroupId = "".obs;
//processingLoading
  var isLoadingWait = false.obs;
//filterId
  var medicineClassificationsIdFilter = "".obs;
  var medicineUnitIdFilter = "".obs;
  var medicineSubGroupIdFilter = "".obs;

  var listPagination = List<MedicineResultSearch>.empty(growable: true).obs;
  var listRecently = <MedicineResultSearch>[].obs;
  var listExportImportInventoryMedicince =
      List<MedicineExportImportInventory>.empty(growable: true).obs;

  Rx<Info> listSelectGame = Info().obs;
  TextEditingController textSearchController = TextEditingController();

  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();

  TextEditingController textNameContraindicationController =
      TextEditingController();
  TextEditingController textDescriptionContraindicationController =
      TextEditingController();
  var isMoreDataAvailable = true.obs;
  var isMoreDataMedicineExportImportInventoryAvailable = true.obs;
  ScrollController scrollControllerMedicineExportImportInventory =
      ScrollController();
  var pagingloading = false.obs;
// create classifiction,unit, subgroup
  TextEditingController textNewClassificationController =
      TextEditingController();
  TextEditingController textNewUnitController = TextEditingController();
  TextEditingController textNewSubGroupController = TextEditingController();
//
  TextEditingController textIcdCodeController = TextEditingController();
  TextEditingController textNameDiagnosticController = TextEditingController();
  TextEditingController textDescriptionDiagnosticController =
      TextEditingController();
//
  Map<String, ValueCompare> searchValueMap = {};
  Map<String, ValueCompare> searchValueCheckDuplicateName = {};
  Map<String, ValueCompare> searchValueMedicineExportImportInventory = {};
  Map<String, ValueCompare> searchClassificationValueMap = {};
  Map<String, ValueCompare> searchSubgroupValueMap = {};
  Map<String, ValueCompare> searchUnitValueMap = {};
  Map<String, ValueCompare> searchValueDiagnostic = {};
  Map<String, ValueCompare> searchValueContraindication = {};

  //
  var month = 1;
  var year = 0;
  var quantityInventory = 0.obs;
  var medicineSearchList = <MedicineInventoryResultSearch>[].obs;
  //
  var isLoadingRecent = true.obs;
//
  var createNew = false;

  SettingController sc = Get.put(SettingController(
      repository: SettingRepository(apiClient: ApiProvider())));
  var pushBottom = false.obs;
  var listAllergySelected = <Allergy>[].obs;
  var listDiagnosticSelected = <Diagnostic>[];
  var listDiagnosticCreateNewSelected = <Diagnostic>[];
  var listContraindicationSelected = <Contraindications>[];

  var listContraindicationDisplay = "";
  var listDiagnosticDisplay = "";
  var showNotifiDuplicateName = false.obs;
  var showNotifiDuplicateNameContraindication = false.obs;
  bool showUpdate = false;
  @override
  void onInit() {
    getTimeNow();
    super.onInit();
  }

  void getTimeNow() {
    DateTime now = new DateTime.now();
    month = now.month;
    year = now.year;
  }

  void paginateList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listPagination,
        isMoreDataAvailable: isMoreDataAvailable,
        limit: pageSize,
        searchValue: searchValueMap,
        sortField: "CreateDate",
        sortOrder: 1,
        selectFields:
            "Id,Name,Description,MedicineClassification,MedicineSubgroup,MedicineUnit",
        searchFuntion: repository.searchMedicine);
  }

  void updateMapSearchValue() {
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueMap,
        valueSearch: textSearchController.text,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "MedicineSubgroupId",
        searchMap: searchValueMap,
        valueSearch: medicineSubGroupIdFilter.value,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "MedicineClassificationId",
        searchMap: searchValueMap,
        valueSearch: medicineClassificationsIdFilter.value,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "MedicineUnitId",
        searchMap: searchValueMap,
        valueSearch: medicineUnitIdFilter.value,
        compare: "Contains");
  }

  void refreshList() async {
    resetTextFilter();
    fetchMedicine();
  }

  updateData() {
    fetchMedicine();
    if (sc.valueSettingMain.value == 1) {
      fetchMedicineRecently();
    }

    if (createNew == false) {
      Get.back();
    }
  }

  void fetchMedicine() async {
    isLoading(true);
    isMoreDataAvailable(true);
    listPagination.clear();
    updateMapSearchValue();

    try {
      var result = await repository.searchMedicine(
        SearchRequest(
            limit: pageSize,
            searchValue: searchValueMap,
            page: currentPage,
            sortField: "CreateDate",
            sortOrder: 1,
            selectFields:
                "Id,Name,Description,MedicineClassification,MedicineSubgroup,MedicineUnit"),
      );
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        print(info.value.limit);
        listPagination.addAll(result.data.data);
        if (listPagination.isEmpty) {
          isFound(false);
        }
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  checkDuplicateNameMedicine(String medicineName) async {
    searchValueCheckDuplicateName.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueCheckDuplicateName,
        valueSearch: medicineName,
        compare: "Equals");
    if (showUpdate == true) {
      GeneralHelper.updateSearchMap(
          fieldSearch: "Id",
          searchMap: searchValueCheckDuplicateName,
          valueSearch: medicineId,
          compare: "Not Equals");
    }
    var list = [];
    if (medicineName.isNotEmpty) {
      try {
        var result = await repository.searchMedicine(
          SearchRequest(
              limit: 1,
              searchValue: searchValueCheckDuplicateName,
              page: 1,
              sortField: "CreateDate",
              sortOrder: 1,
              selectFields: "Id,Name"),
        );
        if (result.statusCode == 200) {
          list = result.data.data;
          if (list.length > 0) {
            showNotifiDuplicateName(true);
          } else {
            showNotifiDuplicateName(false);
          }
        } else {
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  void fetchMedicineRecently() async {
    isLoadingRecent(true);
    try {
      var result = await repository.searchMedicine(
        SearchRequest(
            limit: LIMIT_RECENTLY,
            searchValue: searchValueMap,
            page: currentPage,
            sortField: "CreateDate",
            sortOrder: 1,
            selectFields:
                "Id,Name,Description,MedicineClassification,MedicineSubgroup,MedicineUnit"),
      );
      if (result.statusCode == 200) {
        listRecently.value = result.data.data;
        isLoadingRecent(false);
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } finally {
      isLoadingRecent(false);
    }
  }

  void paginateMedicineExportImportInventoryList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listExportImportInventoryMedicince,
        isMoreDataAvailable: isMoreDataMedicineExportImportInventoryAvailable,
        limit: 5,
        searchValue: searchValueMedicineExportImportInventory,
        sortField: "CreateDate",
        sortOrder: 1,
        selectFields:
            "Medicine.Id as medicineId, Medicine.Name as name, PeriodicInventoryId, PeriodicInventory.Month as month, PeriodicInventory.Year as year, quantity, createDate, ImportMedicine.ExpirationDate as expirationDate, ImportMedicine, ExportMedicines, BeginInventories",
        searchFuntion: repository.searchMedicineExportImportInventory);
  }

  Future fetchExportImportInventoryMedicince() async {
    isMoreDataMedicineExportImportInventoryAvailable(true);
    listExportImportInventoryMedicince.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "medicine.id",
        compare: "Equals",
        valueSearch: medicineId,
        searchMap: searchValueMedicineExportImportInventory);
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        compare: "==",
        valueSearch: year.toString(),
        searchMap: searchValueMedicineExportImportInventory);

    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        compare: "==",
        valueSearch: month.toString(),
        searchMap: searchValueMedicineExportImportInventory);

    var result =
        await repository.searchMedicineExportImportInventory(SearchRequest(
      limit: 5,
      searchValue: searchValueMedicineExportImportInventory,
      page: 1,
      sortField: "CreateDate",
      sortOrder: 1,
      selectFields:
          "Medicine.Id as medicineId, Medicine.Name as name, PeriodicInventoryId, PeriodicInventory.Month as month, PeriodicInventory.Year as year, quantity, createDate, ImportMedicine.ExpirationDate as expirationDate, ImportMedicine, ExportMedicines, BeginInventories",
    ));

    if (result.statusCode == 200) {
      info.value = result.data.info;
      listExportImportInventoryMedicince.addAll(result.data.data);
      if (info.value.totalRecord <= 5) {
        isMoreDataMedicineExportImportInventoryAvailable(false);
      }
    } else {
      GeneralHelper.showMessage(msg: result.message);
    }
  }

  void getDataDetailMedicine() {
    var listDiagnostic = [];
    var listContraindication = [];
    medicineClassificationsId.value =
        medicineDetail.value.medicineClassificationId;
    medicineSubGroupId.value = medicineDetail.value.medicineSubgroupId;
    medicineUnitId.value = medicineDetail.value.medicineUnitId;
    textNameController.text = medicineDetail.value.name;
    textDescriptionController.text = medicineDetail.value.description;
    if (medicineDetail.value.contraindications.isNotEmpty) {
      for (var item in medicineDetail.value.contraindications) {
        listContraindicationSelected.add(item);
        listContraindication.add(item.name);
      }
      listContraindicationDisplay = listContraindication.join(", ");
    } else {
      listContraindicationDisplay = NOINFO;
    }
    if (medicineDetail.value.diagnostics.isNotEmpty) {
      for (var item in medicineDetail.value.diagnostics) {
        listDiagnosticSelected.add(item);
        listDiagnostic.add(item.name);
      }
      listDiagnosticDisplay = listDiagnostic.join(", ");
    } else {
      listDiagnosticDisplay = NOINFO;
    }
  }

  void getDetail() async {
    print(createNew);
    try {
      var result = await repository.getMedicineDetail(medicineId);
      if (result.statusCode == 200) {
        medicineDetail.value = result.data;
        getDataDetailMedicine();
        fetchExportImportInventoryMedicince().then((value) {
          createNew == true
              ? Get.offNamed("/medicineDetail")
              : Get.toNamed("/medicineDetail");
        });
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  // void navigatorToDetail() async {
  //   getDetail().then((value) =>);
  // }

  void navigatorToUpdate() async {
    showUpdate = true;
    clearText();
    getDataDetailMedicine();
    Get.toNamed("/insertMedicine");
  }

  void updateMedicineDetail() async {
    if (validateMedicine()) {
      isLoadingWait(true);
      try {
        var result = await repository.updateMedicine(
            InsertMedicineRequest(
                name: textNameController.text,
                description: textDescriptionController.text,
                medicineClassificationId: medicineClassificationsId.value,
                medicineSubgroupId: medicineSubGroupId.value,
                medicineUnitId: medicineUnitId.value,
                contraindicationIds:
                    listContraindicationSelected.map((e) => e.id).toList(),
                diagnosticIds:
                    listDiagnosticSelected.map((e) => e.id).toList()),
            medicineId);

        if (result.statusCode == 200) {
          isLoadingWait(false);
          getDetail();
          updateData();
          GeneralHelper.showMessage(msg: "Cập nhật thành công");
        } else {
          isLoadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        isLoadingWait(false);
        print(e);
      }
    }
  }

  void removeMedicine() async {
    isLoadingWait(true);
    var result = await repository.deleteMedicine(medicineDetail.value.id);
    if (result.statusCode == 200) {
      isLoadingWait(false);
      updateData();
      GeneralHelper.showMessage(msg: "Xóa dược phẩm thành công");
    } else {
      isLoadingWait(false);
      GeneralHelper.showMessage(msg: result.message);
    }
  }

  void showConfirmRemove() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa dược phẩm này?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () async {
        removeMedicine();
      },
    );
  }

  void getDetailClassificationMedicine(String id) async {
    try {
      var result = await repository.getClassifictionMedicineDetail(id);
      if (result.statusCode == 200) {
        print(result.message);
        medicineClassification.value = result.data;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void getDetailUnitMedicine(String id) async {
    try {
      var result = await repository.getUnitMedicinetDetail(id);
      if (result.statusCode == 200) {
        medicineUnit.value = result.data;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void getDetailSubgroupMedicine(String id) async {
    try {
      var result = await repository.getSubGroupMedicineDetail(id);
      print(result.message);
      if (result.statusCode == 200) {
        medicineSubGroup.value = result.data;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  bool validateMedicine() {
    if (textNameController.text.isEmpty || textNameController.text == "") {
      GeneralHelper.showMessage(msg: 'Vui lòng nhập tên dược phẩm!');
      return false;
    } else if (medicineClassificationsId.isEmpty ||
        medicineClassificationsId.value == "") {
      GeneralHelper.showMessage(msg: "Vui lòng chọn loại dược phẩm!");
      return false;
    } else if (medicineSubGroupId.isEmpty || medicineSubGroupId.value == "") {
      GeneralHelper.showMessage(msg: "Vui lòng chọn nhóm dược phẩm!");
      return false;
    } else if (medicineUnitId.isEmpty || medicineUnitId.value == "") {
      GeneralHelper.showMessage(msg: "Vui lòng chọn đơn vị dược phẩm!");
      return false;
    }
    return true;
  }

  void navigatorInsertMedicine() {
    clearText();
    showUpdate = false;
    showNotifiDuplicateName(false);
    Get.toNamed("/insertMedicine");
  }

  void insertNewMedicine() async {
    if (validateMedicine()) {
      isLoadingWait(true);
      try {
        var result = await repository.insertMedicine(
          InsertMedicineRequest(
              name: textNameController.text,
              description: textDescriptionController.text,
              medicineClassificationId: medicineClassificationsId.value,
              medicineSubgroupId: medicineSubGroupId.value,
              medicineUnitId: medicineUnitId.value,
              contraindicationIds:
                  listContraindicationSelected.map((e) => e.id).toList(),
              diagnosticIds: listDiagnosticSelected.map((e) => e.id).toList()),
        );
        if (result.statusCode == 201) {
          isLoadingWait(false);

          medicineDetail.value = result.data;
          medicineId = medicineDetail.value.id;
          createNew = true;
          updateData();
          getDetail();
          // GeneralHelper.showMessage(
          //     msg: "Tạo dược phẩm thành công",);
        } else {
          isLoadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  Future<List<Contraindications>> fetchContraindicationList(
      String valueSearch) async {
    var listContraindication = <Contraindications>[];
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueContraindication,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await repository.fetchContraindications(SearchRequest(
        limit: 5,
        page: 1,
        sortOrder: 0,
        sortField: "Name",
        searchValue: searchValueContraindication,
        selectFields: "Id,Name"));
    // print("aaaaa" + result.data.data);
    if (result.statusCode == 200) {
      listContraindication = result.data.data;
      return listContraindication;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  void insertNewContraindications() async {
    try {
      var result = await repository.insertContraindication(
        Contraindications(
            name: textNameContraindicationController.text,
            allergyIds: listAllergySelected.map((e) => e.id).toList(),
            diseaseStatusIds:
                listDiagnosticCreateNewSelected.map((e) => e.id).toList()),
      );
      if (result.statusCode == 201) {
        textNameContraindicationController.clear();
        textDescriptionContraindicationController.clear();
        listAllergySelected.clear();
        listDiagnosticCreateNewSelected.clear();
        Get.back();

        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        FocusManager.instance.primaryFocus.unfocus();
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  checkDuplicateNameContraindication(String name) async {
    searchValueCheckDuplicateName.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueCheckDuplicateName,
        valueSearch: name,
        compare: "Equals");
    var list = [];
    if (name.isNotEmpty) {
      try {
        var result = await repository.fetchContraindications(SearchRequest(
            limit: 1,
            page: 1,
            sortOrder: 0,
            sortField: "Name",
            searchValue: searchValueCheckDuplicateName,
            selectFields: "Id,Name"));
        if (result.statusCode == 200) {
          list = result.data.data;
          if (list.length > 0) {
            showNotifiDuplicateNameContraindication(true);
          } else {
            showNotifiDuplicateNameContraindication(false);
          }
        } else {
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  showInsertNewContraindication() {
    listDiagnosticCreateNewSelected.clear();
    listAllergySelected.clear();
    GeneralHelper.showInsertNew(
        title: "Tạo mới chống chỉ định",
        pressOk: insertNewContraindications,
        content: InsertContraindication());
  }

  Future<bool> backScreen() {
    GeneralHelper.showConfirmBackScreenInput(function: clearText);
    return Future.value(true);
  }

  void clearText() {
    textDescriptionController.clear();
    textNameController.clear();
    medicineClassificationsId.value = "";
    medicineUnitId.value = "";
    medicineSubGroupId.value = "";
    listContraindicationSelected.clear();
    listDiagnosticSelected.clear();
    showNotifiDuplicateName(false);
    // textSearchController.clear();
  }

  void clearTextInsertNew() {
    textNewClassificationController.clear();
    textNewSubGroupController.clear();
    textNewUnitController.clear();
  }

  void resetTextFilter() {
    listDiagnosticSelected.clear();
    listContraindicationSelected.clear();
    textSearchController.clear();
    medicineClassificationsIdFilter.value = "";
    medicineSubGroupIdFilter.value = "";
    medicineUnitIdFilter.value = "";
    classificationSelected.value = "";
    subgroupSelected.value = "";
    unitSelected.value = "";
    medicineClassificationsId.value = "";
    medicineSubGroupId.value = "";
    medicineUnitId.value = "";
  }

  Future<List<MedicineClassification>> fetchClassifications(valueSearch) async {
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchClassificationValueMap,
        valueSearch: valueSearch,
        compare: "Contains");
    var result = await repository.fecthMedicineClassifications(SearchRequest(
        limit: 1,
        page: 0,
        sortOrder: 1,
        searchValue: searchClassificationValueMap,
        selectFields: "Id,Name"));
    if (result.statusCode == 200) {
      listMedicineClassifications.value = result.data.data;
      return listMedicineClassifications;
    }
    return [];
  }

  Future<List<dynamic>> fetchUnit(String valueSearch) async {
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchUnitValueMap,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await repository.fecthMedicineUnit(
      SearchRequest(
          limit: 1,
          page: 0,
          sortOrder: 1,
          searchValue: searchUnitValueMap,
          selectFields: "Id,Name"),
    );
    // print("aaaaa" + result.data.data);
    if (result.statusCode == 200) {
      listMedicineUnits.value = result.data.data;
      return listMedicineUnits;
    }
    return [];
  }

  Future<List<dynamic>> fetchSubgroup(String valueSearch) async {
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchSubgroupValueMap,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await repository.fecthMedicineSubgroup(SearchRequest(
        limit: 1,
        page: 0,
        sortOrder: 1,
        searchValue: searchSubgroupValueMap,
        selectFields: "Id,Name"));
    // print("aaaaa" + result.data.data);
    if (result.statusCode == 200) {
      listMedicineSubgroups.value = result.data.data;
      return listMedicineSubgroups;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  void insertNewClassifiction() async {
    try {
      var result = await repository.insertClassificationMedicine(
          MedicineClassification(name: textNewClassificationController.text));
      // print("aaaaa" + result.data.data);
      if (result.statusCode == 201) {
        fetchClassifications("");
        listMedicineClassifications.refresh();
        clearTextInsertNew();
        Get.back();
        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void insertNewSubgroup() async {
    try {
      var result = await repository.insertSubGroupMedicine(
          MedicineSubgroup(name: textNewSubGroupController.text));
      // print("aaaaa" + result.data.data);
      if (result.statusCode == 201) {
        fetchSubgroup("");
        listMedicineSubgroups.refresh();
        clearTextInsertNew();
        Get.back();
        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void insertNewUnit() async {
    try {
      var result = await repository
          .insertUnitMedicine(MedicineUnit(name: textNewUnitController.text));
      // print("aaaaa" + result.data.data);
      if (result.statusCode == 201) {
        fetchUnit("");
        listMedicineUnits.refresh();
        clearTextInsertNew();
        Get.back();
        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void showDialogFilter() {
    GeneralHelper.showFilterDialog(filter: FilterMedicine());
  }
}
