import 'package:fhcs_mobile_application/controller/batches/importMedicineController.dart';
import 'package:fhcs_mobile_application/controller/medicine_inventory/medicineInventoryController.dart';
import 'package:fhcs_mobile_application/controller/setting/settingController.dart';
import 'package:fhcs_mobile_application/data/model/import_batch/import_batch.dart';
import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicine_result_search/medicine_result_search.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/priceMaxMin/price_max_min.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_batch_medicine_request/insert_batch_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_import_batch/insert_import_batch_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/response/response_import_batch_detail/response_import_batch_detail.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/import_batch_repository.dart';
import 'package:fhcs_mobile_application/data/repository/import_medicine_repository.dart';
import 'package:fhcs_mobile_application/data/repository/medicine_inventory_repository.dart';
import 'package:fhcs_mobile_application/data/repository/setting_repository.dart';
import 'package:fhcs_mobile_application/screens/ManageImportBatches/filter_batches/filter_import_batch_dialog.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class BatchesMedicineController extends GetxController {
  final ImportBatchRepository importBatchRepository;
  final ImportMedicineRepository importMedicineRepository;
  BatchesMedicineController(
      {@required this.importBatchRepository, this.importMedicineRepository})
      : assert(importBatchRepository != null);
  var listImportMedicine = List<ImportBatchMedicine>.empty(growable: true).obs;
  var listMedicineInsertBatchLocal = <ImportBatchMedicine>[].obs;
  var importMedicine = ImportBatchMedicine().obs;
  var medicineList = <MedicineResultSearch>[].obs;
  var importBatchDetail = ImportBatchDetail().obs;
  var listImportBatch = List<ImportBatch>.empty(growable: true).obs;
  var listRecently = List<ImportBatch>.empty(growable: true).obs;
  TextEditingController textPeriodicMonthController = TextEditingController();
  TextEditingController textPeriodicYearController = TextEditingController();
  TextEditingController textDesController = TextEditingController();
  TextEditingController textQuantityController = TextEditingController();
  TextEditingController textPriceController = TextEditingController();
  TextEditingController textSearhMedicineController = TextEditingController();
  TextEditingController textPeriodicMonthFilterController =
      TextEditingController();
  TextEditingController textPeriodicYearFilterController =
      TextEditingController();
  TextEditingController textFromPriceFilterController = TextEditingController();
  TextEditingController textQuantityFilterController = TextEditingController();
  TextEditingController textToPriceFilterController = TextEditingController();
  TextEditingController warningDateController = TextEditingController();
  var vndFormat = new NumberFormat.currency(locale: "vi_VN", symbol: "₫");
  var importBatchId = "";
  var importMedicineId = "";
  var unitMedicineSelect = "".obs;
  var medicineId = "";
  var dateInsert = "".obs;
  var dateExpiration = "".obs;
  var dateWarningExpiration = "".obs;
  var periodicMonth = "".obs;
  var periodicYear = "".obs;
  var dateUpdate = "".obs;
  var isLoadingWait = false.obs;
  var uuid = Uuid();
  var numberMedicineInBatch = 0.obs;
  var showUpdate = false;
  RxDouble totalPrice = RxDouble(0);
  var enableEdit = false.obs;
  Map<String, ValueCompare> searchValueMapMedicine = {};
  Map<String, ValueCompare> searchValueMapImportBatch = {};
  Map<String, ValueCompare> searchValueMapMedicineInImportBatch = {};
  Map<String, ValueCompare> searchValueMapCheckDuplicateMedicineInImportBatch =
      {};
  var info = Info().obs;
  var currentPage = 1;
  var pageSize = 10;
  var isLoading = true.obs;
  var isFound = true.obs;
  var pagingloading = false.obs;
  var checkDuplicate = true.obs;
  DateTime selectedDate;
  var monthSelect = "".obs;
  var periodicMonthFilter = "";
  var periodicYearFilter = "";
  var fromDateFilter = "";
  var statusId = 0;
  var toDateFilter = "";
  var isMoreImportBatchesAvailable = true.obs;
  var isMoreImportMedicineAvailable = true.obs;
  var showButtonAddNew = false.obs;
  var inBatches = false;
  var currentIndex = 0.obs;
  double maxTotalPrice;
  double minTotalPrice;
  double maxFilterTotalPrice;
  double minFilterTotalPrice;
  ImportMedicineController imc = Get.put(ImportMedicineController(
      importMedicineRepository:
          ImportMedicineRepository(apiClient: ApiProvider())));
  MedicineInventoryController mic = Get.put(MedicineInventoryController(
      repository: MedicineInventoryRepository(apiClient: ApiProvider())));
  SettingController sc = Get.put(SettingController(
      repository: SettingRepository(apiClient: ApiProvider())));
  var isLoadingRecent = true.obs;
  var currentMonth;
  var currentYear;
  bool canUpdate = true;
  bool createNew = false;
  var countTouchEdit = 0;
  @override
  void onInit() {
    getTimeNow();

    super.onInit();
  }

  void getTimeNow() {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    dateInsert.value = GeneralHelper.formatDateText(date.toString(), false);
    textPeriodicMonthController.text = now.month.toString();
    textPeriodicYearController.text = now.year.toString();
    currentMonth = now.month;
    currentYear = now.year;
  }

  void paginateList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listImportBatch,
        isMoreDataAvailable: isMoreImportBatchesAvailable,
        limit: pageSize,
        searchValue: searchValueMapImportBatch,
        sortField: "CreateDate",
        sortOrder: 1,
        selectFields:
            "id,NumberOfSpecificMedicine,totalPrice,createDate,PeriodicInventory",
        searchFuntion: importBatchRepository.searchImportBatch);
  }

  void fetchImportBatch() async {
    isLoading(true);
    isMoreImportBatchesAvailable(true);
    listImportBatch.clear();
    updateMapSearchValueImportBatches();

    try {
      var result = await importBatchRepository.searchImportBatch(
        SearchRequest(
            limit: pageSize,
            searchValue: searchValueMapImportBatch,
            page: currentPage,
            sortField: "CreateDate",
            sortOrder: 1,
            selectFields:
                "id, NumberOfSpecificMedicine,totalPrice,createDate,PeriodicInventory"),
      );
      if (result.statusCode == 200) {
        isFound(true);
        info.value = result.data.info;
        print(info.value.totalRecord);
        listImportBatch.addAll(result.data.data);
        if (listImportBatch.isEmpty) {
          isFound(false);
        }
        if (info.value.totalRecord <= pageSize) {
          isMoreImportBatchesAvailable(false);
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

  void fetchImportBatchesRecently() async {
    isLoadingRecent(true);
    try {
      var result = await importBatchRepository.searchImportBatch(
        SearchRequest(
            limit: LIMIT_RECENTLY,
            searchValue: searchValueMapImportBatch,
            page: currentPage,
            sortField: "CreateDate",
            sortOrder: 1,
            selectFields:
                "id, NumberOfSpecificMedicine,totalPrice,createDate,PeriodicInventory"),
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

  void refreshList() async {
    resetTextFilter();
    fetchImportBatch();
  }

  void cleanData() {
    //showUpdate = false;
    listMedicineInsertBatchLocal.clear();
    //  isLoadingWait(false);
  }

  showHideEdit() {
    showButtonAddNew.value = !showButtonAddNew.value;
  }

  void updateMapSearchValueImportBatches() {
    GeneralHelper.updateSearchMap(
        fieldSearch: "NumberOfSpecificMedicine",
        searchMap: searchValueMapImportBatch,
        valueSearch: textQuantityFilterController.text,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Month",
        searchMap: searchValueMapImportBatch,
        valueSearch: selectedDate != null ? selectedDate.month.toString() : "",
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "PeriodicInventory.Year",
        searchMap: searchValueMapImportBatch,
        valueSearch: selectedDate != null ? selectedDate.year.toString() : "",
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "CreateDate|from",
        searchMap: searchValueMapImportBatch,
        valueSearch: fromDateFilter ?? "",
        compare: ">=");
    //filter date
    GeneralHelper.updateSearchMap(
        fieldSearch: "CreateDate|to",
        searchMap: searchValueMapImportBatch,
        valueSearch: toDateFilter ?? "",
        compare: "<=");
    //filter total price
    GeneralHelper.updateSearchMap(
        fieldSearch: "TotalPrice|from",
        searchMap: searchValueMapImportBatch,
        valueSearch:
            minFilterTotalPrice != null ? minFilterTotalPrice.toString() : "",
        compare: ">=");
    GeneralHelper.updateSearchMap(
        fieldSearch: "TotalPrice|to",
        searchMap: searchValueMapImportBatch,
        valueSearch:
            maxFilterTotalPrice != null ? maxFilterTotalPrice.toString() : "",
        compare: "<=");
    //filter periodic
  }

  updateDataServer() {
    print("Current screen main:" + sc.valueSettingMain.value.toString());
    if (sc.valueSettingMain.value == 3) {
      imc.fetchImportMedicineRecently();
    } else if (sc.valueSettingMain.value == 2) {
      fetchImportBatchesRecently();
    } else if (sc.valueSettingMain.value == 4) {
      mic.fetchMedicineInventoryRecently();
    }
    fetchImportBatch();
  }

  void insertNewImportBatch() async {
    if (listMedicineInsertBatchLocal.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng thêm dược phẩm vào lô nhập ");
    } else {
      isLoadingWait(true);
      try {
        var result = await importBatchRepository
            .insertImportBatch(InsertImportBatchRequest(
          importMedicines: listMedicineInsertBatchLocal,
          periodicInventoryMonth: currentMonth.toString(),
          periodicInventoryYear: currentYear.toString(),
          totalPrice: totalPrice.value,
        ));
        print(result.statusCode);
        if (result.statusCode == 201) {
          isLoadingWait(false);
          importBatchDetail.value = result.data;
          importBatchId = importBatchDetail.value.id;
          updateDataServer();
          createNew = true;
          getDetailImportBatch();
        } else {
          isLoadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        isLoadingWait(false);
        GeneralHelper.showMessage(msg: e.toString());
        print(e);
      }
    }
  }

  void updateNewImportBatch() async {
    if (listMedicineInsertBatchLocal.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng thêm dược phẩm vào lô nhập ");
    } else if (textPeriodicMonthController.text.isEmpty ||
        textPeriodicYearController.text.isEmpty) {
      GeneralHelper.showMessage(msg: "Vui lòng nhập kỳ và năm ");
    } else {
      isLoadingWait(true);
      try {
        var result = await importBatchRepository.updateImportBatch(
            InsertImportBatchRequest(
              importMedicines: listMedicineInsertBatchLocal,
              periodicInventoryMonth: currentMonth.toString(),
              periodicInventoryYear: currentYear.toString(),
              totalPrice: totalPrice.value,
            ),
            importBatchId);
        if (result.statusCode == 200) {
          isLoadingWait(false);
          updateDataServer();
          getDetailImportBatch();
          cleanData();
          Get.back();
          GeneralHelper.showMessage(msg: "Cập nhật lô nhập thành công");
        } else {
          isLoadingWait(false);
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        isLoadingWait(false);
        GeneralHelper.showMessage(msg: e.toString());
        print(e);
      }
    }
  }

  Future getMinMaxTotalImportBatch() async {
    try {
      PriceMaxMin priceMaxMin;
      var result = await importBatchRepository.getMinMaxPriceImportBatch();
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

//fetch medicine in import batch detail

  navigatorUpdateImportBatch() {
    listMedicineInsertBatchLocal.clear();
    showUpdate = true;
    fetchAllListMedicineImportBatchDetail();
    billBatch();
    textPeriodicMonthController.text = periodicMonth.value;
    textPeriodicYearController.text = periodicYear.value;
    numberMedicineInBatch.value =
        importBatchDetail.value.numberOfSpecificMedicine;
    totalPrice.value = importBatchDetail.value.totalPrice;
    Get.toNamed("/insertBatchesMedicine");
  }

  Future fetchAllListMedicineImportBatchDetail() async {
    GeneralHelper.updateSearchMap(
        fieldSearch: "ImportBatchId",
        searchMap: searchValueMapMedicineInImportBatch,
        valueSearch: importBatchId,
        compare: "Equals");

    try {
      var result = await importMedicineRepository.searchMedicineInImportBatch(
        SearchRequest(
            limit: 4,
            searchValue: searchValueMapMedicineInImportBatch,
            page: 1,
            sortField: "importBatch.createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit.name as unit,medicineId,importMedicineStatus,warningExpirationDate"),
      );
      if (result.statusCode == 200) {
        info.value = result.data.info;
        listMedicineInsertBatchLocal.value = result.data.data;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void paginateImportMedicine(int page) {
    GeneralHelper.paging(
        info: info,
        listPagination: listImportMedicine,
        isMoreDataAvailable: isMoreImportMedicineAvailable,
        limit: page,
        searchValue: searchValueMapMedicineInImportBatch,
        sortField: "importBatch.createDate",
        sortOrder: 1,
        selectFields:
            "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit as medicineUnit,importMedicineStatus",
        searchFuntion: importMedicineRepository.searchMedicineInImportBatch);
  }

  Future fetchListMedicineImportBatchDetail() async {
    isMoreImportMedicineAvailable(true);
    listImportMedicine.clear();
    searchValueMapMedicineInImportBatch.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "ImportBatchId",
        searchMap: searchValueMapMedicineInImportBatch,
        valueSearch: importBatchId,
        compare: "Equals");

    try {
      var result = await importMedicineRepository.searchMedicineInImportBatch(
        SearchRequest(
            limit: 5,
            searchValue: searchValueMapMedicineInImportBatch,
            page: 1,
            sortField: "importBatch.createDate",
            sortOrder: 1,
            selectFields:
                "id,quantity,price,description,insertDate,expirationDate,importBatchId,medicine.name as name,medicine.MedicineUnit as medicineUnit,importMedicineStatus,medicineId,warningExpirationDate"),
      );
      if (result.statusCode == 200) {
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
    } finally {}
  }

  void getDetailImportBatch() async {
    try {
      var result =
          await importBatchRepository.getImportBatchDetail(importBatchId);
      if (result.statusCode == 200) {
        importBatchDetail.value = result.data;
        periodicMonth.value =
            importBatchDetail.value.periodicInventory.month.toString();
        periodicYear.value =
            importBatchDetail.value.periodicInventory.year.toString();
        dateUpdate.value = importBatchDetail.value.updateDate;
        numberMedicineInBatch.value =
            importBatchDetail.value.numberOfSpecificMedicine;
        totalPrice.value = importBatchDetail.value.totalPrice;
        showButtonAddNew(false);
        canUpdate = GeneralHelper.checkCurrentPeriodic(
          importBatchDetail.value.periodicInventory.month,
          importBatchDetail.value.periodicInventory.year,
        );
        fetchListMedicineImportBatchDetail().then((value) {
          createNew == true
              ? Get.offNamed("/importBatchMedicineDetail")
              : Get.toNamed("/importBatchMedicineDetail");
        });
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void removeImportBatch() async {
    var result = await importBatchRepository.deleteImportBatch(importBatchId);
    isLoadingWait(true);
    try {
      if (result.statusCode == 200) {
        isLoadingWait(false);
        updateDataServer();
        Get.back();
        GeneralHelper.showMessage(msg: "Xóa lô nhập thành công");
      } else {
        isLoadingWait(false);
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void showConfirmRemoveImportBatch() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa lô nhập này?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () {
        removeImportBatch();
      },
    );
  }

  // void navigatorToUpdate() async {
  //   // textNameController.text = medicineDetail.value.name;
  //   // textDescriptionController.text = medicineDetail.value.description;
  //   // isLoadingLoggin.value = false;
  //   Get.toNamed("/updateMedicine");
  // }

  void getDetailImportMedicine() async {
    countTouchEdit = 0;
    try {
      var result = await importMedicineRepository
          .getMedicineInImportBatchDetail(importMedicineId);
      if (result.statusCode == 200) {
        importMedicine.value = result.data;
        textDesController.text = importMedicine.value.description;
        dateInsert.value = importMedicine.value.insertDate;
        textSearhMedicineController.text =
            importMedicine.value.name ?? importMedicine.value.medicine.name;
        dateExpiration.value = importMedicine.value.expirationDate;
        dateWarningExpiration.value =
            importMedicine.value.warningExpirationDate;
        medicineId = importMedicine.value.medicineId;
        textQuantityController.text = importMedicine.value.quantity.toString();
        textPriceController.text = vndFormat
            .format(importMedicine.value.price)
            .substring(0, importMedicine.value.price.toString().length - 1);

        textSearhMedicineController.text = importMedicine.value.name;
        statusId = importMedicine.value.importMedicineStatus.id;
        canUpdate = GeneralHelper.checkCurrentPeriodic(
          importMedicine.value.periodicInventory.month,
          importMedicine.value.periodicInventory.year,
        );
        checkShowDelete();
        enableEdit(false);
        Get.toNamed("/updateBatchesMedicineRecord");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void updateMedicineImport() async {
    isLoadingWait(true);
    checkDuplicate(false);
    if (checkValidateText()) {
      checkDuplicateServerRecord().then((value) async {
        if (value == false) {
          try {
            var result =
                await importMedicineRepository
                    .updateMedicineInImportBatch(
                        InsertMedicineInImportBatchRequest(
                            quantity: int.parse(textQuantityController.text),
                            description: textDesController.text,
                            insertDate: GeneralHelper.formatDateText(
                                dateInsert.value, false),
                            expirationDate: GeneralHelper.formatDateText(
                                dateExpiration.value, false),
                            warningExpirationDate: GeneralHelper.formatDateText(
                                dateWarningExpiration.value, false),
                            price: double.parse(
                                textPriceController.text.numericOnly()),
                            medicineId: medicineId),
                        importMedicineId);

            if (result.statusCode == 200) {
              isLoadingWait(false);
              if (inBatches != false) {
                getDetailImportBatch();
                updateDataServer();
              } else {
                currentIndex.value = 1;
                imc.fetchImportMedicine();
                updateDataServer();
              }
              Get.back();
              GeneralHelper.showMessage(msg: "Cập nhật thành công");
            } else {
              isLoadingWait(false);
              GeneralHelper.showMessage(msg: result.message);
            }
          } on Exception catch (e) {
            isLoadingWait(false);
            print(e);
          }
        } else {
          isLoadingWait(false);
        }
      });
    } else {
      isLoadingWait(false);
    }
  }

  Future<List<ImportBatchMedicine>>
      checkDuplicateMedicineInImportBatch() async {
    print(checkDuplicate);
    GeneralHelper.updateSearchMap(
        fieldSearch: "ImportBatchId",
        searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
        valueSearch: importBatchId,
        compare: "Equals");
    GeneralHelper.updateSearchMap(
        fieldSearch: "Price",
        searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
        valueSearch: textPriceController.text.numericOnly(),
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "InsertDate",
        searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
        valueSearch: dateInsert.value,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "ExpirationDate",
        searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
        valueSearch: dateExpiration.value,
        compare: "==");
    GeneralHelper.updateSearchMap(
        fieldSearch: "MedicineId",
        searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
        valueSearch: medicineId,
        compare: "Equals");

    if (checkDuplicate.isFalse) {
      GeneralHelper.updateSearchMap(
          fieldSearch: "Id",
          searchMap: searchValueMapCheckDuplicateMedicineInImportBatch,
          valueSearch: importMedicine.value.id,
          compare: "Not Equals");
    }
    var result = await importMedicineRepository.searchMedicineInImportBatch(
      SearchRequest(
          limit: 1,
          searchValue: searchValueMapCheckDuplicateMedicineInImportBatch,
          page: 0,
          sortField: "",
          sortOrder: 0,
          selectFields:
              "id,quantity,price,insertDate,expirationDate,warningExpirationDate,importBatchId,medicine.name as name,medicine.id as medicineId"),
    );
    if (result.statusCode == 200) {
      // isFound(true);
      info.value = result.data.info;
      return listMedicineInsertBatchLocal.value = result.data.data;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  Future<bool> checkDuplicateServerRecord() async {
    await checkDuplicateMedicineInImportBatch();
    print(listMedicineInsertBatchLocal.length);
    if (listMedicineInsertBatchLocal.length > 0) {
      GeneralHelper.showConfirm(
          msg: "",
          title:
              "Dược phẩm này đã tồn tại trong danh sách nhập kho,bạn có muốn cập nhật thêm số lượng?",
          textOk: "Cập nhật",
          textCancel: "Hủy",
          pressCancel: () {},
          pressOk: () async {
            try {
              var result =
                  await importMedicineRepository.updateMedicineInImportBatch(
                InsertMedicineInImportBatchRequest(
                    quantity: int.parse(textQuantityController.text) +
                        listMedicineInsertBatchLocal.first.quantity,
                    medicineId: listMedicineInsertBatchLocal.first.medicineId,
                    price: listMedicineInsertBatchLocal.first.price,
                    expirationDate:
                        listMedicineInsertBatchLocal.first.expirationDate,
                    warningExpirationDate: listMedicineInsertBatchLocal
                        .first.warningExpirationDate),
                listMedicineInsertBatchLocal.first.id,
              );

              if (result.statusCode == 200) {
                isLoadingWait(false);
                updateDataServer();
                getDetailImportBatch();
                Get.back();
                GeneralHelper.showMessage(msg: "Cập nhật thành công");
              } else {
                isLoadingWait(false);
                GeneralHelper.showMessage(msg: result.message);
              }
            } on Exception catch (e) {
              isLoadingWait(false);
              print(e);
            }
          });
      return true;
    }
    return false;
  }

  void insertMedicineImport() async {
    checkDuplicate(true);
    if (checkValidateText()) {
      var value = await checkDuplicateServerRecord();
      if (value == false) {
        try {
          isLoadingWait(true);
          var result =
              await importMedicineRepository.insertMedicineInImportBatch(
                  InsertMedicineInImportBatchRequest(
                      quantity: int.parse(textQuantityController.text),
                      description: textDesController.text,
                      insertDate: dateInsert.value,
                      warningExpirationDate: dateWarningExpiration.value,
                      expirationDate: dateExpiration.value,
                      price:
                          double.parse(textPriceController.text.numericOnly()),
                      medicineId: medicineId),
                  importBatchId);

          if (result.statusCode == 201) {
            isLoadingWait(false);
            updateDataServer();
            getDetailImportBatch();
            Get.back();
            GeneralHelper.showMessage(msg: "Đã thêm 1 dược phẩm vào lô");
          } else {
            isLoadingWait(false);
            GeneralHelper.showMessage(msg: result.message);
          }
        } on Exception catch (e) {
          isLoadingWait(false);

          print(e);
        }
      } else {
        print("not");
      }
    }
  }

  checkShowDelete() {
    if (statusId == 2) {
      print(statusId);
      return false;
    } else {
      return true;
    }
  }

  void showConfirmRemoveMedicineInImportBatch() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa dược phẩm khỏi lô nhập?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () {
        removeMedicineInImportBatch();
      },
    );
  }

  void removeMedicineInImportBatch() async {
    var result = await importMedicineRepository
        .deleteMedicineInImportBatch(importMedicineId);

    try {
      if (result.statusCode == 200) {
        print(Get.currentRoute);
        if (inBatches != false) {
          getDetailImportBatch();
          updateDataServer();
        } else {
          imc.fetchImportMedicine();
          updateDataServer();
        }
        Get.back();
        GeneralHelper.showMessage(msg: "Đã xóa dược phẩm nhập");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void showDialogImportBatchesFilter() {
    getMinMaxTotalImportBatch().then(
        (value) => GeneralHelper.showFilterDialog(filter: FilterImportBatch()));
  }

//controller import medicine
//
//
//
//
//
//

//local
//
//
//
//
//
//
//
//
  Future fetchMedicine() async {
    // await Future.delayed(Duration(seconds: 1));
    searchValueMapMedicine.update(
        "Name",
        (value) => ValueCompare(
            value: textSearhMedicineController.text, compare: "Contains"),
        ifAbsent: () => ValueCompare(
            value: textSearhMedicineController.text, compare: "Contains"));
    try {
      var result = await importBatchRepository.searchMedicine(
        SearchRequest(
            limit: 5,
            searchValue: searchValueMapMedicine,
            page: 1,
            sortField: "CreateDate",
            sortOrder: 1,
            selectFields: "Id,Name,MedicineUnit"),
      );
      if (result.statusCode == 200) {
        medicineList.value = result.data.data;
      }
    } finally {}
  }

  Future<List<MedicineResultSearch>> getMedicineSuggestions() async {
    fetchMedicine();
    return medicineList;
  }

  void addNewMedicineToBatchLocal() {
    if (checkValidateText() && !checkDuplicateLocalRecord()) {
      try {
        listMedicineInsertBatchLocal.add(
          ImportBatchMedicine(
              quantity: int.parse(textQuantityController.text),
              insertDate: dateInsert.value,
              expirationDate: dateExpiration.value,
              price: double.parse(textPriceController.text.numericOnly()),
              medicineId: medicineId,
              warningExpirationDate: dateWarningExpiration.value,
              name: textSearhMedicineController.text,
              description: textDesController.text,
              id: uuid.v1(),
              unit: unitMedicineSelect.value),
        );
        billBatch();
        Get.back();
        resetText();
        GeneralHelper.showSuccessToast(msg: "Đã thêm dược phẩm vào lô");
      } on Exception catch (e) {
        print("bug:  " + e.toString());
      }
    }
  }

  checkDuplicateLocalRecord() {
    print("a");
    if (listMedicineInsertBatchLocal.isNotEmpty) {
      var contain = listMedicineInsertBatchLocal.where((u) =>
          u.name == textSearhMedicineController.text &&
          GeneralHelper.formatDateText(u.insertDate, false) ==
              dateInsert.value &&
          GeneralHelper.formatDateText(u.expirationDate, false) ==
              dateExpiration.value &&
          u.price == double.parse(textPriceController.text.numericOnly()));
      if (contain.length != 0) {
        print(contain.first.id);

        GeneralHelper.showConfirm(
            msg: "",
            textCancel: "Hủy",
            textOk: "Cập nhật",
            title:
                "Dược phẩm này đã tồn tại trong danh sách nhập kho,bạn có muốn cập nhật thêm số lượng?",
            pressCancel: () {},
            pressOk: () {
              importMedicine.value = listMedicineInsertBatchLocal
                  .where((b) => b.id == contain.first.id)
                  .first;
              importMedicine.value.quantity = contain.first.quantity +
                  int.parse(textQuantityController.text);
              updateDataLocal();
              Get.back();
            });
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  bool checkValidateText() {
    if (textSearhMedicineController.text.isEmpty) {
      GeneralHelper.showMessage(msg: 'Vui lòng chọn dược phẩm!');
      return false;
    } else if (textQuantityController.text.isEmpty) {
      GeneralHelper.showMessage(msg: 'Vui lòng nhập số lượng!');
      return false;
    } else if (int.parse(textQuantityController.text) == 0) {
      GeneralHelper.showMessage(msg: 'Số lượng phải lớn hơn 0!');
      return false;
    } else if (textPriceController.text.isEmpty) {
      GeneralHelper.showMessage(msg: 'Vui lòng nhập đơn giá!');
      return false;
    } else if (int.parse(textPriceController.text.numericOnly()) <= 0 ||
        textPriceController.text.contains("-")) {
      GeneralHelper.showMessage(msg: 'Đơn giá phải lớn hơn 0!');
      return false;
    } else if (dateInsert.value.isEmpty ||
        dateExpiration.value.isEmpty ||
        dateWarningExpiration.value.isEmpty) {
      GeneralHelper.showMessage(msg: 'Vui lòng chọn ngày!');
      return false;
    } else if (checkValidateDate() == "expirationDate") {
      GeneralHelper.showMessage(msg: 'Ngày hết hạn không hợp lệ!');
      return false;
    } else if (checkValidateDate() == "warningExpirationDate") {
      GeneralHelper.showMessage(msg: 'Ngày cảnh báo không hợp lệ!');
      return false;
    }
    return true;
  }

  String checkValidateDate() {
    DateTime expirationDate =
        new DateFormat("yyyy-MM-dd").parse(dateExpiration.value);
    DateTime warningExpirationDate =
        new DateFormat("yyyy-MM-dd").parse(dateWarningExpiration.value);
    DateTime insertDate = new DateFormat("yyyy-MM-dd").parse(dateInsert.value);
    DateTime now =
        new DateFormat("yyyy-MM-dd").parse(DateTime.now().toString());
    if (expirationDate.isBefore(now) || expirationDate.isBefore(insertDate)) {
      return "expirationDate";
    }
    if (warningExpirationDate.isBefore(now) ||
        warningExpirationDate.isBefore(insertDate) ||
        warningExpirationDate.isAfter(expirationDate)) {
      return "warningExpirationDate";
    }
    return "validate";
  }

  Future<bool> backScreen() {
    debugPrint("_pop");
    if (listMedicineInsertBatchLocal.length != 0) {
      GeneralHelper.showConfirm(
        title: "Chắc chắn rời khỏi trang này?",
        msg: "Thông tin vừa nhập sẽ không được lưu lại.",
        pressCancel: () {},
        textCancel: "Ở Lại",
        textOk: "Rời khỏi",
        pressOk: () {
          cleanData();
          Get.back();
        },
      );
    } else {
      Get.back();
    }
    return Future.value(false);
  }

  resetText() {
    textDesController.clear();
    dateExpiration.value = "";
    dateWarningExpiration.value = "";
    medicineId = "";
    textQuantityController.clear();
    textPriceController.clear();
    textSearhMedicineController.clear();
    unitMedicineSelect.value = "";
    checkDuplicate(true);
    getTimeNow();
  }

  resetTextFilter() {
    monthSelect.value = "";
    selectedDate = null;
    textFromPriceFilterController.clear();
    textToPriceFilterController.clear();
    textQuantityFilterController.clear();
    fromDateFilter = "";
    toDateFilter = "";
    maxFilterTotalPrice = maxTotalPrice;
    minFilterTotalPrice = minTotalPrice;
  }

  billBatch() {
    numberMedicineInBatch.value = listMedicineInsertBatchLocal.length;
    totalPrice.value = listMedicineInsertBatchLocal.fold(
        0, (sum, item) => sum + item.price * item.quantity);
  }

  updateDataLocal() {
    billBatch();
    listMedicineInsertBatchLocal.refresh();
  }

  void getMedicineInBatchDetailLocal() {
    enableEdit(false);

    importMedicine.value = listMedicineInsertBatchLocal
        .where((b) => b.id == importMedicineId)
        .first;
    textDesController.text = importMedicine.value.description;
    dateInsert.value = importMedicine.value.insertDate;
    textSearhMedicineController.text =
        importMedicine.value.name ?? importMedicine.value.medicine.name;
    dateExpiration.value = importMedicine.value.expirationDate;
    dateWarningExpiration.value = importMedicine.value.warningExpirationDate;
    medicineId = importMedicine.value.medicineId;
    textQuantityController.text = importMedicine.value.quantity.toString();
    textPriceController.text = vndFormat
        .format(importMedicine.value.price)
        .substring(0, importMedicine.value.price.toString().length - 1);
    textSearhMedicineController.text = importMedicine.value.name;

    Get.toNamed("/updateInsertMedicineRecordLocal");
  }

  void showConfirmRemove() {
    GeneralHelper.showConfirm(
      title: "Chắc chắn muốn xóa dược phẩm khỏi lô nhập?",
      msg: "",
      pressCancel: () {},
      textCancel: "Hủy",
      textOk: "Xóa",
      pressOk: () {
        deleteMedicineInBatch();
      },
    );
  }

  void deleteMedicineInBatch() {
    listMedicineInsertBatchLocal.removeWhere((b) => b.id == importMedicineId);
    updateDataLocal();
    Get.back();
    GeneralHelper.showSuccessToast(msg: "Đã xóa dược phẩm ");
  }

  // void closeScreen() {
  //   Get.back();
  // }
  void setEnableUpdate() {
    enableEdit(true);
    countTouchEdit++;
    if (countTouchEdit == 1)
      GeneralHelper.showMessageToast(msg: "Đã cho phép chỉnh sửa");
  }

  void updateBatch() {
    if (checkValidateText()) {
      importMedicine.value = listMedicineInsertBatchLocal
          .where((b) => b.id == importMedicineId)
          .first;
      importMedicine.value.description = textDesController.text;
      importMedicine.value.insertDate = dateInsert.value;
      importMedicine.value.expirationDate = dateExpiration.value;
      importMedicine.value.warningExpirationDate = dateWarningExpiration.value;
      importMedicine.value.medicineId = medicineId;
      importMedicine.value.quantity = int.parse(textQuantityController.text);
      importMedicine.value.price =
          double.parse(textPriceController.text.numericOnly());
      importMedicine.value.name = textSearhMedicineController.text;
      updateDataLocal();
      Get.back();
      GeneralHelper.showSuccessToast(msg: "Cập nhật thành công");
    }
  }
}
