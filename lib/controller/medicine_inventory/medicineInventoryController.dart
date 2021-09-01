import 'package:fhcs_mobile_application/data/model/medicine_inventory_result_search/medicine_inventory_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/priceMaxMin/price_max_min.dart';
import 'package:fhcs_mobile_application/data/model/requests/eliminate_medicine_request/eliminate_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_medicine_inventory_detail/response_medicine_inventory_detail.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_inventory_repository.dart';
import 'package:fhcs_mobile_application/screens/ManageMedicineInventory/filter/filter_medicine_inventory_dialog.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicineInventoryController extends GetxController {
  final MedicineInventoryRepository repository;
  MedicineInventoryController({@required this.repository})
      : assert(repository != null);
  var medicineInventory = MedicineInventoryResultSearch().obs;
  var listPagination =
      List<MedicineInventoryResultSearch>.empty(growable: true).obs;
  var listRecently =
      List<MedicineInventoryResultSearch>.empty(growable: true).obs;
  var medicineInventoryDetail = MedicineInventoryDetailResponse().obs;
  var isLoading = true.obs;
  var isFound = true.obs;
  var isMoreDataAvailable = true.obs;
  var currentPage = 1;
  var pageSize = 10;
  var pagingloading = false.obs;
  var info = Info().obs;
  var medicineInventoryDetailId = "";
  var loadingWait = false.obs;
  var canUpdate = true;
  DateTime selectedDate;
  var monthSelect = "".obs;
  TextEditingController textQuantityController = TextEditingController();
  TextEditingController textReasonController = TextEditingController();
  TextEditingController textSearchController = TextEditingController();
  TextEditingController textQuantityFilterController = TextEditingController();
  var fromCreateDateFilter = "";
  var toCreatedDateFilter = "";
  var fromDateExpirationFilter = "";
  var toDateExpirationFilter = "";
  double maxTotalPrice;
  double minTotalPrice;
  double maxFilterTotalPrice;
  double minFilterTotalPrice;
  Map<String, ValueCompare> searchValueMap = {};
  var isLoadingRecent = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void refreshList() async {
    resetTextFilter();
    fetchMedicineInventory();
  }

  void updateMapSearchValue() {
    //filter periodic
    GeneralHelper.updateSearchMap(
        fieldSearch: "medicine.name",
        searchMap: searchValueMap,
        valueSearch: textSearchController.text,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "quantity",
        searchMap: searchValueMap,
        valueSearch: textQuantityFilterController.text,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        searchMap: searchValueMap,
        valueSearch: selectedDate != null ? selectedDate.year.toString() : "",
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        searchMap: searchValueMap,
        valueSearch: selectedDate != null ? selectedDate.month.toString() : "",
        compare: "==");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "createDate|from",
        searchMap: searchValueMap,
        valueSearch: fromCreateDateFilter,
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "createDate|to",
        searchMap: searchValueMap,
        valueSearch: toCreatedDateFilter,
        compare: "<=");

    GeneralHelper.updateSearchMap(
        fieldSearch: "importMedicine.expirationDate|from",
        searchMap: searchValueMap,
        valueSearch: fromDateExpirationFilter,
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "importMedicine.expirationDate|to",
        searchMap: searchValueMap,
        valueSearch: toDateExpirationFilter,
        compare: "<=");
    // GeneralHelper.updateSearchMap(
    //     fieldSearch: "importMedicine.price|from",
    //     searchMap: searchValueMap,
    //     valueSearch:
    //         minFilterTotalPrice != null ? minFilterTotalPrice.toString() : "",
    //     compare: ">=");
    // GeneralHelper.updateSearchMap(
    //     fieldSearch: "importMedicine.price|to",
    //     searchMap: searchValueMap,
    //     valueSearch:
    //         maxFilterTotalPrice != null ? maxFilterTotalPrice.toString() : "",
    //     compare: "<=");
  }

  void paginateList() {
    GeneralHelper.paging(
        info: info,
        isMoreDataAvailable: isMoreDataAvailable,
        searchValue: searchValueMap,
        listPagination: listPagination,
        limit: pageSize,
        sortField: "importMedicine.insertDate",
        sortOrder: 1,
        selectFields:
            "id,quantity,importMedicine.insertDate,importMedicine.expirationDate,medicine.name,periodicInventory.month ,periodicInventory.year,medicine.medicineUnit.name as unitName",
        searchFuntion: repository.searchMedicineInventoryDetail);
  }

  Future getMinMaxPriceImportMedicineFilter() async {
    try {
      PriceMaxMin priceMaxMin;
      var result = await repository.getMinMaxPriceImportMedicine();
      if (result.statusCode == 200) {
        priceMaxMin = result.data;
        maxTotalPrice = priceMaxMin.priceMax;
        minTotalPrice = priceMaxMin.priceMin;
        if (maxFilterTotalPrice == null && minFilterTotalPrice == null) {
          maxFilterTotalPrice = priceMaxMin.priceMax;
          minFilterTotalPrice = priceMaxMin.priceMin;
        }
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void fetchMedicineInventory() async {
    isLoading(true);
    isMoreDataAvailable(true);
    listPagination.clear();
    updateMapSearchValue();

    try {
      var result = await repository.searchMedicineInventoryDetail(
        SearchRequest(
            limit: pageSize,
            searchValue: searchValueMap,
            page: 1,
            sortField: "createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,importMedicine.insertDate,importMedicine.expirationDate,medicine.name,periodicInventory.month ,periodicInventory.year,medicine.medicineUnit.name as unitName"),
      );
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        listPagination.addAll(result.data.data);
        if (listPagination.isEmpty) {
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

  void fetchMedicineInventoryRecently() async {
    isLoadingRecent(true);
    try {
      var result = await repository.searchMedicineInventoryDetail(
        SearchRequest(
            limit: LIMIT_RECENTLY,
            searchValue: searchValueMap,
            page: 1,
            sortField: "createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,importMedicine.insertDate,importMedicine.expirationDate,medicine.name,periodicInventory.month ,periodicInventory.year,medicine.medicineUnit.name as unitName"),
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

  void getDetailMeicineInventory() async {
    try {
      var result = await repository
          .getMedicineInventoryDetail(medicineInventoryDetailId);
      if (result.statusCode == 200) {
        // await Future.delayed(Duration(seconds: 1));

        medicineInventoryDetail.value = result.data;
        canUpdate = GeneralHelper.checkCurrentPeriodic(
          medicineInventoryDetail.value.periodicInventory.month,
          medicineInventoryDetail.value.periodicInventory.year,
        );
        Get.toNamed("/medicineInventoryDetail");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  showDialogEliminateMedicine() {
    GeneralHelper.showInputEliminate(
      title: "Hủy dược phẩm",
      pressOk: () {
        if (validateEliminate()) {
          eliminateMedicineInventory();
        }
      },
      controllerQuantity: textQuantityController,
      controllerReason: textReasonController,
    );
  }

  bool validateEliminate() {
    if (textQuantityController.text == "" || textReasonController.text == "") {
      GeneralHelper.showMessage(msg: "Vui lòng không để trống");
      return false;
    } else if (int.parse(textQuantityController.text) <= 0) {
      GeneralHelper.showMessage(msg: "Số lượng phải lớn hơn 0");
      return false;
    }
    return true;
  }

  updateData() {
    getDetailMeicineInventory();
    fetchMedicineInventory();
  }

  void eliminateMedicineInventory() async {
    loadingWait(true);
    try {
      var result = await repository.eliminateMedicine((EliminateMedicineRequest(
          medicineInInventoryDetailId: medicineInventoryDetailId,
          quantity: int.parse(textQuantityController.text),
          reason: textReasonController.text)));
      if (result.statusCode == 201) {
        Get.back();
        await Future.delayed(Duration(seconds: 1));
        loadingWait(false);
        updateData();
        GeneralHelper.showMessage(msg: "Đã hủy dược phẩm");
        textQuantityController.clear();
        textReasonController.clear();
      } else {
        loadingWait(false);
        print(result.statusCode);
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      loadingWait(false);
      print(e);
    }
  }

  resetTextFilter() {
    textSearchController.clear();
    monthSelect.value = "";
    selectedDate = null;
    fromCreateDateFilter = "";
    toCreatedDateFilter = "";
    fromDateExpirationFilter = "";
    toDateExpirationFilter = "";
  }

  void showDialogFilter() {
    // getMinMaxPriceImportMedicineFilter().then((value) =>
    GeneralHelper.showFilterDialog(filter: FilterMedicineInventory());
  }
}
