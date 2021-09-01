import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/priceMaxMin/price_max_min.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/repository/import_medicine_repository.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/filter_batches/filter_import_medicine_dialog.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';

import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ImportMedicineController extends GetxController {
  final ImportMedicineRepository importMedicineRepository;
  ImportMedicineController({@required this.importMedicineRepository});

  var listImportMedicine = List<ImportBatchMedicine>.empty(growable: true).obs;
  var listRecently = List<ImportBatchMedicine>.empty(growable: true).obs;
  Map<String, ValueCompare> searchValueMapImportMedicine = {};
  var info = Info().obs;
  var currentPage = 1;
  var pageSize = 10;
  var isLoading = true.obs;
  var isFound = true.obs;
  var monthSelect = "".obs;
  var statusId = 0.obs;
  DateTime selectedDate;
  var toDateFilter = "";
  var isMoreImportMedicineAvailable = true.obs;
  TextEditingController textQuantityController = TextEditingController();
  TextEditingController textReasonController = TextEditingController();
  TextEditingController textSearchController = TextEditingController();
  TextEditingController textQuantityFilterController = TextEditingController();
  var fromCreateDateFilter = "";
  var toCreatedDateFilter = "";
  var fromDateExpirationFilter = "";
  var toDateExpirationFilter = "";
  var importMedicineStatusFliter = "".obs;
  double maxTotalPrice;
  double minTotalPrice;
  double maxFilterTotalPrice;
  double minFilterTotalPrice;
  var isLoadingRecent = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void paginateImportMedicine() {
    GeneralHelper.paging(
        info: info,
        listPagination: listImportMedicine,
        isMoreDataAvailable: isMoreImportMedicineAvailable,
        limit: pageSize,
        searchValue: searchValueMapImportMedicine,
        sortField: "importBatch.createDate",
        sortOrder: 1,
        selectFields:
            "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit as medicineUnit,importMedicineStatus",
        searchFuntion: importMedicineRepository.searchMedicineInImportBatch);
  }

  void updateMapSearchValueImportMedicine() {
    //filter periodic
    GeneralHelper.updateSearchMap(
        fieldSearch: "medicine.name",
        searchMap: searchValueMapImportMedicine,
        valueSearch: textSearchController.text,
        compare: "Contains");
    GeneralHelper.updateSearchMap(
        fieldSearch: "quantity",
        searchMap: searchValueMapImportMedicine,
        valueSearch: textQuantityFilterController.text,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "importBatch.PeriodicInventory.Year",
        searchMap: searchValueMapImportMedicine,
        valueSearch: selectedDate != null ? selectedDate.year.toString() : "",
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "importBatch.PeriodicInventory.Month",
        searchMap: searchValueMapImportMedicine,
        valueSearch: selectedDate != null ? selectedDate.month.toString() : "",
        compare: "==");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "insertDate|from",
        searchMap: searchValueMapImportMedicine,
        valueSearch: fromCreateDateFilter,
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "insertDate|to",
        searchMap: searchValueMapImportMedicine,
        valueSearch: toCreatedDateFilter,
        compare: "<=");

    GeneralHelper.updateSearchMap(
        fieldSearch: "expirationDate|from",
        searchMap: searchValueMapImportMedicine,
        valueSearch: fromDateExpirationFilter,
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "expirationDate|to",
        searchMap: searchValueMapImportMedicine,
        valueSearch: toDateExpirationFilter,
        compare: "<=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "price|from",
        searchMap: searchValueMapImportMedicine,
        valueSearch:
            minFilterTotalPrice != null ? minFilterTotalPrice.toString() : "",
        compare: ">=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "price|to",
        searchMap: searchValueMapImportMedicine,
        valueSearch:
            maxFilterTotalPrice != null ? maxFilterTotalPrice.toString() : "",
        compare: "<=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "StatusId",
        searchMap: searchValueMapImportMedicine,
        valueSearch: importMedicineStatusFliter.value,
        compare: "==");
  }

  void fetchImportMedicineRecently() async {
    isLoadingRecent(true);
    try {
      var result = await importMedicineRepository.searchMedicineInImportBatch(
        SearchRequest(
            limit: LIMIT_RECENTLY,
            searchValue: searchValueMapImportMedicine,
            page: 1,
            sortField: "importBatch.createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit as medicineUnit,importMedicineStatus,medicineId,warningExpirationDate"),
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

  Future fetchImportMedicine() async {
    isLoading(true);
    isMoreImportMedicineAvailable(true);
    listImportMedicine.clear();
    updateMapSearchValueImportMedicine();

    try {
      var result = await importMedicineRepository.searchMedicineInImportBatch(
        SearchRequest(
            limit: 10,
            searchValue: searchValueMapImportMedicine,
            page: 1,
            sortField: "importBatch.createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit as medicineUnit,importMedicineStatus,medicineId,warningExpirationDate"),
      );
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        listImportMedicine.addAll(result.data.data);
        if (info.value.totalRecord <= 5) {
          isMoreImportMedicineAvailable(false);
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

  resetTextFilter() {
    textSearchController.clear();
    monthSelect.value = "";
    selectedDate = null;
    fromCreateDateFilter = "";
    toCreatedDateFilter = "";
    fromDateExpirationFilter = "";
    toDateExpirationFilter = "";
    textQuantityFilterController.clear();
    maxFilterTotalPrice = maxTotalPrice;
    minFilterTotalPrice = minTotalPrice;
    importMedicineStatusFliter.value = "";
  }

  Future getMinMaxPriceImportMedicineFilter() async {
    try {
      PriceMaxMin priceMaxMin;
      var result =
          await importMedicineRepository.getMinMaxPriceImportMedicine();
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

  void showDialogFilter() {
    getMinMaxPriceImportMedicineFilter().then((value) =>
        GeneralHelper.showFilterDialog(filter: FilterImportMedicine()));
  }

  void refreshList() async {
    resetTextFilter();
    fetchImportMedicine();
  }
}
