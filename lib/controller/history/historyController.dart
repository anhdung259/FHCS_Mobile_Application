import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/treatment_info_result_search/treatment_info_result_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/repository/history_repository.dart';
import 'package:fhcs_mobile_application/screens/history/filter/filter_history_dialog.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final HistoryRepository repository;
  HistoryController({@required this.repository}) : assert(repository != null);
  var listPaginationPatient = List<Patient>.empty(growable: true).obs;
  var listHistoryPatient =
      List<TreatmentInfoResultSearch>.empty(growable: true).obs;
  var patientDetail = Patient().obs;
  var isLoading = true.obs;
  var isFound = true.obs;
  var isMoreDataAvailable = true.obs;
  var isMoreListHistoryPatient = true.obs;
  var currentPage = 1;
  var pageSize = 7;
  var pageSizeHistory = 5;
  var pagingloading = false.obs;
  var info = Info().obs;
  var patientId = "";
  var loadingWait = false.obs;
  var genderFilter = "".obs;
  var departmentFilter = "".obs;
  var listAllergyDisplay = "";
  TextEditingController textQuantityController = TextEditingController();
  TextEditingController textReasonController = TextEditingController();
  TextEditingController textSearchController = TextEditingController();
  TextEditingController textPeriodicMonthFilterController =
      TextEditingController();
  TextEditingController textPeriodicYearFilterController =
      TextEditingController();

  Map<String, ValueCompare> searchValuePatient = {};

  Map<String, ValueCompare> searchValueTreatmentInfo = {};
  @override
  void onInit() {
    super.onInit();
  }

  void refreshListPatient() async {
    resetTextFilter();
    fetchPatientList();
  }

  void refreshListHistoryTreatment() async {
    resetTextFilter();
    fetchHistoryTreatmentInfoPatient();
  }

  void updateMapSearchPatientValue() {
    //filter periodic
    GeneralHelper.updateSearchMap(
        fieldSearch: "name",
        searchMap: searchValuePatient,
        valueSearch: textSearchController.text,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "departmentId",
        searchMap: searchValuePatient,
        valueSearch: departmentFilter.value,
        compare: "Equals");
    GeneralHelper.updateSearchMap(
        fieldSearch: "gender",
        searchMap: searchValuePatient,
        valueSearch: genderFilter.value,
        compare: "Equals");
  }

  void paginatePatientList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listPaginationPatient,
        isMoreDataAvailable: isMoreDataAvailable,
        limit: pageSize,
        sortOrder: 1,
        searchValue: searchValuePatient,
        selectFields: "id,internalCode,name,department",
        searchFuntion: repository.fetchPatient);
  }

  void fetchPatientList() async {
    isLoading(true);
    isMoreDataAvailable(true);
    listPaginationPatient.clear();
    updateMapSearchPatientValue();

    try {
      var result = await repository.fetchPatient(SearchRequest(
          limit: pageSize,
          page: 1,
          sortOrder: 1,
          searchValue: searchValuePatient,
          selectFields: "id,internalCode,name,department"));
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        print(info.value.totalRecord);
        listPaginationPatient.addAll(result.data.data);
        if (listPaginationPatient.isEmpty) {
          isFound(false);
        }
        if (info.value.totalRecord <= pageSize) {
          isMoreDataAvailable(false);
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

  void getDetailPatient() async {
    var listAllergy = [];
    try {
      var result = await repository.getPatientDetail(patientId);
      if (result.statusCode == 200) {
        // await Future.delayed(Duration(seconds: 1));
        patientDetail.value = result.data;
        fetchHistoryTreatmentInfoPatient()
            .then((value) => Get.toNamed("/patientDetail"));
        if (patientDetail.value.allergies.isNotEmpty) {
          for (var item in patientDetail.value.allergies) {
            listAllergy.add(item.name);
          }
          listAllergyDisplay = listAllergy.join(", ");
        } else {
          listAllergyDisplay = NOINFO;
        }
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void paginateListHistoryTreatmentInfoPatient() {
    GeneralHelper.paging(
        info: info,
        listPagination: listHistoryPatient,
        isMoreDataAvailable: isMoreListHistoryPatient,
        limit: pageSizeHistory,
        sortField: "createAt",
        sortOrder: 1,
        selectFields:
            "id,createAt,isDelivered,patient.name as patientName,patient.department.name as departmentName",
        searchValue: searchValueTreatmentInfo,
        searchFuntion: repository.searchTreatmentInfo);
  }

  Future fetchHistoryTreatmentInfoPatient() async {
    isMoreListHistoryPatient(true);
    listHistoryPatient.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "patient.id",
        searchMap: searchValueTreatmentInfo,
        valueSearch: patientId,
        compare: "Equals");

    var result = await repository.searchTreatmentInfo(
      SearchRequest(
          limit: pageSizeHistory,
          searchValue: searchValueTreatmentInfo,
          page: 1,
          sortField: "createAt",
          sortOrder: 1,
          selectFields:
              "id,createAt, isDelivered, patient.name as patientName, patient.department.name as departmentName"),
    );
    if (result.statusCode == 200) {
      info.value = result.data.info;
      listHistoryPatient.addAll(result.data.data);
      if (info.value.totalRecord <= pageSizeHistory) {
        isMoreListHistoryPatient(false);
      }
    } else {
      GeneralHelper.showMessage(msg: result.message);
    }
  }

  resetTextFilter() {
    textSearchController.clear();
    genderFilter.value = "";
    departmentFilter.value = "";
  }

  void showDialogFilter() {
    GeneralHelper.showFilterDialog(filter: FilterPatientList());
  }
}
