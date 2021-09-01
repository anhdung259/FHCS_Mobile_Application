import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fhcs_mobile_application/data/model/account/account.dart';
import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/app_version/app_version.dart';
import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/department/department.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/import_batch_medicine/import_batch_medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicine/medicine.dart';
import 'package:fhcs_mobile_application/data/model/medicineClassification/medicine_classification.dart';
import 'package:fhcs_mobile_application/data/model/medicineSubgroup/medicine_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/medicineUnit/medicine_unit.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/data/model/priceMaxMin/price_max_min.dart';
import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/eliminate_medicine_request/eliminate_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_batch_medicine_request/insert_batch_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_import_batch/insert_import_batch_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_medicine_request/insert_medicine_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/insert_treament_info_request/insert_treament_info_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/notifi_click_request/notifi_click_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/requests/update_profile_request/update_profile_request.dart';
import 'package:fhcs_mobile_application/data/model/response/responseSearchMedicine/response_search_medicine.dart';
import 'package:fhcs_mobile_application/data/model/response/response_import_batch_detail/response_import_batch_detail.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_allergy/response_list_allergy.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_classification/medicine_classification_list.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_contraindications/response_list_contraindications.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_department/response_list_department.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_disease_status/response_list_disease_status.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_medicine_in_import_batch/response_list_medicine_in_import_batch.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_notification/response_list_notification.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_patient/response_list_patient.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_subgroup/response_list_subgroup.dart';
import 'package:fhcs_mobile_application/data/model/response/response_list_unit/response_list_unit.dart';
import 'package:fhcs_mobile_application/data/model/response/response_medicine_export_import_inventory_list/response_medicine_export_import_inventory_list.dart';
import 'package:fhcs_mobile_application/data/model/response/response_medicine_inventory_detail/response_medicine_inventory_detail.dart';
import 'package:fhcs_mobile_application/data/model/response/response_search_import_batch/response_search_import_batch.dart';
import 'package:fhcs_mobile_application/data/model/response/response_search_medicine_inventory/response_search_medicine_inventory.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/model/response/response_treatment_info_detail/response_treatment_info_detail.dart';
import 'package:fhcs_mobile_application/data/model/response/response_treatment_info_result_list/response_treatment_info_result_list.dart';
import 'package:fhcs_mobile_application/data/model/response/tokenForgotPassword/token_forgot_password.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/service/http_service.dart';
import 'package:fhcs_mobile_application/shared/shared_server_api_urls/server_api__urls.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiProvider {
  Map<String, String> header = {
    'Accept': '*/*',
    //'Content-Type': 'application/json;',
    'Accept-Encoding': 'gzip, deflate, br'
  };
  String getParams(SearchRequest request) {
    String includes = "";
    String groupBys = "";
    String diseaseStatusIds = "";
    String allergyIds = "";
    if (request.allergyIds != null) {
      request.allergyIds.asMap().forEach((i, e) {
        allergyIds += "&allergyIds[$i]=$e";
      });
    }
    if (request.diagnosticIds != null) {
      request.diagnosticIds.asMap().forEach((i, e) {
        diseaseStatusIds += "&diagnosticIds[$i]=$e";
      });
    }
    if (request.includes != null) {
      request.includes.asMap().forEach((i, e) {
        includes += "&includes[$i]=$e";
      });
    }

    if (request.includes != null) {
      request.includes.asMap().forEach((i, e) {
        includes += "&includes[$i]=$e";
      });
    }
    if (request.groupBys != null) {
      request.groupBys.asMap().forEach((i, e) {
        groupBys += "&groupBys[$i]=$e";
      });
    }
    String generalParams =
        "Limit=${request.limit}&Page=${request.page}&SortField=${request.sortField ?? ""}&SortOrder=${request.sortOrder}&SelectFields=${request.selectFields}";

    String searchValueParams = "";
    if (request.searchValue != null) {
      request.searchValue.entries.forEach((e) {
        searchValueParams +=
            "SearchValue[${e.key}].value=${e.value.value}&SearchValue[${e.key}].compare=${e.value.compare}&";
      });
    }
    return "?" +
        searchValueParams +
        generalParams +
        includes +
        groupBys +
        diseaseStatusIds +
        allergyIds;
  }

  void addHeaderRefresh(String key, String value) {
    header[key] = value;
  }

  void addHeader(String key, String value) {
    header[key] = value;
    GeneralHelper.refreshTokenApi();
  }

  void addHeaderForgotPassword(String key, String value) {
    header[key] = value;
    // GeneralHelper.checkTokenExpiration();
  }

//
//authorize
  Future<ResponseServer> authUserGoogle(AuthRequest request) async {
    return HttpService.post(APIUSERAUTHORIZE, Account.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> authUsernamePassword(AuthRequest request) async {
    return HttpService.post(APIUSERAUTHORIZEUSERPASS, Account.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> refreshToken() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeaderRefresh('Authorization', 'Bearer ' + token);
    return HttpService.get(APIREFRESHTOKEN, Account.instance(),
        headers: header);
  }

  Future<ResponseServer> sendCode(AuthRequest request) async {
    return HttpService.post(
        APISENDINGCODEFORGOTPASSWORD, TokenForgotPassword.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> verifyCodeAccount(AuthRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeaderForgotPassword('Authorization', 'Bearer ' + token);
    return HttpService.post(APIVERIFYCODEFORGOTPASSWORD, null,
        headers: header, data: request);
  }

  Future<ResponseServer> changeForgotPassword(AuthRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeaderForgotPassword('Authorization', 'Bearer ' + token);
    return HttpService.post(APICHANGINGFORGOTPASSWORD, null,
        headers: header, data: request);
  }

  Future<ResponseServer> changeNewPassword(AuthRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APICHANGINGNEWPASSWORD, null,
        headers: header, data: request);
  }

//
//medicine
  Future<ResponseServer> searchMedicine(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    String params = getParams(request);
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(
        APISEARCHMEDICINE + params, MedicineResponseSearch.instance(),
        headers: header);
  }

  Future<ResponseServer> fecthMedicineClassifications(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APIFETCHMEDICINECLASSIFICATION + params,
        MedicineClassificationList.instance(),
        headers: header);
  }

  Future<ResponseServer> fecthMedicineUnit(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APIFETCHMEDICINEUNIT + params, MedicineUnitResponse.instance(),
        headers: header);
  }

  Future<ResponseServer> fecthMedicineSubgroup(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APIFETCHMEDICINESUBGROUP + params, MedicineSubgroupResponse.instance(),
        headers: header);
  }

  Future<ResponseServer> insertMedicine(InsertMedicineRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIMEDICINE, Medicine.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> updateMedicine(
      InsertMedicineRequest request, String medicineId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.put(APIMEDICINE + "/$medicineId", Medicine.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> getMedicineDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String queryParameter =
        "?SelectFields=id,name,description,createDate,medicineSubgroup.name as nameSubgroup, medicineClassification.name as nameClassification, medicineUnit.name as nameUnit,medicineUnitId,medicineSubgroupId,medicineClassificationId,Contraindications,diagnostics";
    return HttpService.get(
        APIMEDICINE + "/$id" + queryParameter, Medicine.instance(),
        headers: header);
  }

  Future<ResponseServer> deleteMedicine(String medicineId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.delete(APIMEDICINE + "/$medicineId", headers: header);
  }

//medicine subgroup,unit , classification
  Future<ResponseServer> getSubGroupMedicineDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(
        APIMEDICINESUBGROUPS + "/$id", MedicineSubgroup.instance(),
        headers: header);
  }

  Future<ResponseServer> getUnitMedicinetDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(APIMEDICINEUNITS + "/$id", MedicineUnit.instance(),
        headers: header);
  }

  Future<ResponseServer> getClassifictionMedicineDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(
        APIMEDICINECLASSIFICATION + "/$id", MedicineClassification.instance(),
        headers: header);
  }

  Future<ResponseServer> insertClassificationMedicine(
      MedicineClassification request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(
        APIMEDICINECLASSIFICATION, MedicineClassification.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> insertSubGroupMedicine(
      MedicineSubgroup request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIMEDICINESUBGROUPS, MedicineSubgroup.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> insertUnitMedicine(MedicineUnit request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIMEDICINEUNITS, MedicineUnit.instance(),
        headers: header, data: request);
  }

//
//profile
  Future<ResponseServer> getProfileInfo() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(APIGETUSERPROFILE, Account.instance(),
        headers: header);
  }

  Future<ResponseServer> updateProfile() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.put(APIUPDATEPROFILE, Account.instance(),
        headers: header);
  }

  Future<ResponseServer> updateProfileUser(
      UpdateProfileRequest updateProfileRequest) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    FormData formData = new FormData();
    if (updateProfileRequest.avatarFile != null) {
      formData = new FormData.fromMap({
        'DisplayName': updateProfileRequest.displayName,
        'Description': updateProfileRequest.description,
        'PhoneNumber': updateProfileRequest.phoneNumber,
        'AvatarFile':
            await MultipartFile.fromFile(updateProfileRequest.avatarFile.path)
      });
    } else {
      formData = new FormData.fromMap({
        'DisplayName': updateProfileRequest.displayName,
        'Description': updateProfileRequest.description,
        'PhoneNumber': updateProfileRequest.phoneNumber,
      });
    }
    return HttpService.put(APIUPDATEPROFILE, Account.instance(),
        data: formData, typeRequest: HttpService.FORMDATA, headers: header);
  }

//
//import batch
  Future<ResponseServer> searchImportBatch(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHIMPORTBATCHMEDICINE + params,
        ImportBatchResponseSearch.instance(),
        headers: header);
  }

  Future<ResponseServer> insertImportBatch(
      InsertImportBatchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(
        APIIMPORTBATCHMEDICINE, ImportBatchDetail.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> updateImportBatch(
      InsertImportBatchRequest request, String importId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.put(
        APIIMPORTBATCHMEDICINE + "/$importId", ImportBatchMedicine.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> getImportBatchDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params =
        "?selectFields=id,totalPrice,numberOfSpecificMedicine,periodicInventory,updateDate,createDate";
    return HttpService.get(
        APIIMPORTBATCHMEDICINE + "/$id" + params, ImportBatchDetail.instance(),
        headers: header);
  }

  Future<ResponseServer> deleteImportBatch(String importBatchId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.delete(APIIMPORTBATCHMEDICINE + "/$importBatchId",
        headers: header);
  }

  Future<ResponseServer> getMinMaxPriceImportBatch() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(
        APIIMPORTBATCHMEDICINE + "/MinMaxPrice", PriceMaxMin.instance(),
        headers: header);
  }
//
//medicine in import batch

  Future<ResponseServer> searchMedicineInImportBatch(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHMEDICINEINIMPORTBATCH + params,
        MedicineInImportBatchList.instance(),
        headers: header);
  }

  Future<ResponseServer> insertMedicineInImportBatch(
      InsertMedicineInImportBatchRequest request, String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(
        APIMEDICINEINIMPORTBATCH + "/$id", ImportBatchMedicine.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> updateMedicineInImportBatch(
      InsertMedicineInImportBatchRequest request, String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.put(
        APIMEDICINEINIMPORTBATCH + "/$id", ImportBatchMedicine.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> getMedicineInImportBatchDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params =
        "?SelectFields=Id, Quantity,Price, InsertDate, ExpirationDate, Description, MedicineId, Medicine, Medicine.MedicineUnit,importMedicineStatus,warningExpirationDate,importBatch.periodicInventory";
    return HttpService.get(APIMEDICINEINIMPORTBATCH + "/$id" + params,
        ImportBatchMedicine.instance(),
        headers: header);
  }

  Future<ResponseServer> deleteMedicineInImportBatch(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.delete(APIMEDICINEINIMPORTBATCH + "/$id",
        headers: header);
  }

// medicine inventory

  Future<ResponseServer> searchMedicineInventoryDetail(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHMEDICINEINVENTORYDETAIL + params,
        MedicineInventoryResponseSearch.instance(),
        headers: header);
  }

  Future<ResponseServer> getMinMaxPriceImportMedicine() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(
        APIMEDICINEINIMPORTBATCH + "/MinMaxPrice", PriceMaxMin.instance(),
        headers: header);
  }

  Future<ResponseServer> searchMedicineExportImportInventory(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHMEDICINEINVENTORYDETAIL + params,
        MedicineExportImportInventoryList.instance(),
        headers: header);
  }

  Future<ResponseServer> getMedicineInventoryDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    String params =
        "?selectFields=id,importMedicine,quantity,medicine,createDate,periodicInventory,medicine.medicineUnit, medicine.medicineClassification,medicine.medicineSubgroup";
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(APIMEDICINEINVENTORYDETAIL + "/$id" + params,
        MedicineInventoryDetailResponse.instance(),
        headers: header);
  }

//search inventory to prescription
  Future<ResponseServer> searchMedicineInventories(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHMEDICINEINVENTORYDETAIL + params,
        MedicineInventoryResponseSearch.instance(),
        headers: header);
  }

//
//eliminate medicicine
  Future<ResponseServer> eliminateMedicine(
      EliminateMedicineRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIELIMINATEMEDICINE, null,
        headers: header, data: request);
  }

//
//department
  Future<ResponseServer> fetchDepartment(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APIDEPARTMENTSEARCH + params, DepartmentList.instance(),
        headers: header);
  }

  Future<ResponseServer> insertDepartment(Department request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIDEPARTMENT, null,
        headers: header, data: request);
  }

//diseaseStatus
  Future<ResponseServer> fetchDiagnostic(
      SearchRequest request, String paramCodeName) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APIDIAGNOSTICSEARCH + params + "&searchCodeName=$paramCodeName",
        DiseaseStatusList.instance(),
        headers: header);
  }

  Future<ResponseServer> insertDiagnostic(Diagnostic request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIDIAGNOSTIC, Diagnostic.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> insertAllergy(Allergy request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APIALLERGY, Allergy.instance(),
        headers: header, data: request);
  }

  Future<ResponseServer> fetchAllergy(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APIALLERGYSEARCH + params, AllergyList.instance(),
        headers: header);
  }

  Future<ResponseServer> fetchContraindications(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APICONTRAINDICATIONSEARCH + params, ContraindicationsList.instance(),
        headers: header);
  }

  Future<ResponseServer> insertContraindication(
      Contraindications request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(APICONTRAINDICATION, Contraindications.instance(),
        headers: header, data: request);
  }

//patient
  Future<ResponseServer> fetchPatient(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APIPATIENTSEARCH + params, PatientList.instance(),
        headers: header);
  }

  Future<ResponseServer> getPatientByInternalCode(String internalCode) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String queryParameter =
        "?selectFields=id,internalCode,name,gender,recentTimeGetTreatment,allergies,department.id as departmentId";
    return HttpService.get(
        APIPATIENTBYINTERNALCODE + "/$internalCode" + queryParameter,
        Patient.instance(),
        headers: header);
  }

  Future<ResponseServer> getPatientDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String queryParameter = "?selectFields";
    return HttpService.get(
        APIPATIENT + "/$id" + queryParameter, Patient.instance(),
        headers: header);
  }

//treatmentInfo
  Future<ResponseServer> searchTreatmentInfo(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APISEARCHTREATMENTINFORMATION + params,
        TreatmentInfoResultList.instance(),
        headers: header);
  }

  Future<ResponseServer> getTreatmentInfoDetail(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String queryParameter =
        "?selectFields=patient,patient.department.name as departmentName,confirmSignature,accountCreateBy.displayName as createdBy,periodicInventory.month, periodicInventory.year,TreatmentInformations,diagnostics,isDelivered,createAt,patient.allergies,diseaseStatuses";
    return HttpService.get(APITREATMENTINFORMATION + "/$id" + queryParameter,
        TreatmentInfoDetailResponse.instance(),
        headers: header);
  }

  Future<ResponseServer> confirmTreatmentInfo(
      InsertTreatmentInfoRequest request, String treatmentId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    var queryParameter = "/" + treatmentId;
    FormData formData;
    if (request.confirmSignatureImg != null) {
      formData = new FormData.fromMap({
        'ConfirmSignatureImg':
            await MultipartFile.fromFile(request.confirmSignatureImg.path)
      });
    }
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.post(
        APICONFIRMTREATMENTINFORMATION + queryParameter, null,
        headers: header, data: formData, typeRequest: HttpService.FORMDATA);
  }

  Future<ResponseServer> deleteTreatmentInfo(String treatmentId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.delete(APITREATMENTINFORMATION + "/$treatmentId",
        headers: header);
  }

  Future<ResponseServer> insertTreatmentInfo(
      InsertTreatmentInfoRequest insertTreatmentInfoRequest) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    FormData formData = new FormData();
    formData = new FormData.fromMap({
      'Patient.InternalCode': insertTreatmentInfoRequest.internalCode,
      'Patient.Name': insertTreatmentInfoRequest.name,
      'Patient.Gender': insertTreatmentInfoRequest.gender,
      'Patient.DepartmentId': insertTreatmentInfoRequest.departmentId,
      'Patient.AllergyIds': insertTreatmentInfoRequest.allergyIds,
      'DiseaseStatuses': insertTreatmentInfoRequest.diseaseStatuses,
      'DiagnosticIds': insertTreatmentInfoRequest.diagnosticIds,
      'TreatmentInformations': List.generate(
        insertTreatmentInfoRequest.treatmentInformations.length,
        (i) {
          return {
            "MedicineId":
                insertTreatmentInfoRequest.treatmentInformations[i].medicineId,
            "Quantity":
                insertTreatmentInfoRequest.treatmentInformations[i].quantity,
            "IndicationToDrink": insertTreatmentInfoRequest
                .treatmentInformations[i].indicationToDrink,
            'TreatmentInformationDetails': List.generate(
              insertTreatmentInfoRequest.treatmentInformationDetails
                  .where((e) =>
                      e.medicineId ==
                      insertTreatmentInfoRequest
                          .treatmentInformations[i].medicineId)
                  .toList()
                  .length,
              (p) {
                return {
                  "MedicineInInventoryDetailId": insertTreatmentInfoRequest
                      .treatmentInformationDetails
                      .where((e) =>
                          e.medicineId ==
                          insertTreatmentInfoRequest
                              .treatmentInformations[i].medicineId)
                      .toList()[p]
                      .medicineInInventoryDetailId,
                  "Quantity": insertTreatmentInfoRequest
                      .treatmentInformationDetails
                      .where((e) =>
                          e.medicineId ==
                          insertTreatmentInfoRequest
                              .treatmentInformations[i].medicineId)
                      .toList()[p]
                      .quantity,
                };
              },
            ),
          };
        },
      ),
      'IsDelivered': insertTreatmentInfoRequest.isDelivered,
      'ConfirmSignatureImg':
          insertTreatmentInfoRequest.confirmSignatureImg != null
              ? await MultipartFile.fromFile(
                  insertTreatmentInfoRequest.confirmSignatureImg.path)
              : null
    });
    print(formData.fields);
    return HttpService.post(
        APITREATMENTINFORMATION, TreatmentInfoDetailResponse.instance(),
        data: formData, typeRequest: HttpService.FORMDATA, headers: header);
  }

  Future<ResponseServer> checkQuanityAvaiable(String id) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    String params = "?selectFields=quantity";
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(APIMEDICINEINVENTORYDETAIL + "/$id" + params,
        MedicineInventoryDetailResponse.instance(),
        headers: header);
  }

  Future<ResponseServer> updateTreatmentInfo(
      InsertTreatmentInfoRequest insertTreatmentInfoRequest,
      String treatmentId) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    FormData formData = new FormData();
    formData = new FormData.fromMap({
      'Patient.InternalCode': insertTreatmentInfoRequest.internalCode,
      'Patient.Name': insertTreatmentInfoRequest.name,
      'Patient.Gender': insertTreatmentInfoRequest.gender,
      'Patient.DepartmentId': insertTreatmentInfoRequest.departmentId,
      'Patient.AllergyIds': insertTreatmentInfoRequest.allergyIds,
      'DiseaseStatuses': insertTreatmentInfoRequest.diseaseStatuses,
      'DiagnosticIds': insertTreatmentInfoRequest.diagnosticIds,
      'TreatmentInformations': List.generate(
        insertTreatmentInfoRequest.treatmentInformations.length,
        (i) {
          return {
            "MedicineId":
                insertTreatmentInfoRequest.treatmentInformations[i].medicineId,
            "Quantity":
                insertTreatmentInfoRequest.treatmentInformations[i].quantity,
            "IndicationToDrink": insertTreatmentInfoRequest
                .treatmentInformations[i].indicationToDrink,
            'TreatmentInformationDetails': List.generate(
              insertTreatmentInfoRequest.treatmentInformationDetails
                  .where((e) =>
                      e.medicineId ==
                      insertTreatmentInfoRequest
                          .treatmentInformations[i].medicineId)
                  .toList()
                  .length,
              (p) {
                return {
                  "MedicineInInventoryDetailId": insertTreatmentInfoRequest
                      .treatmentInformationDetails
                      .where((e) =>
                          e.medicineId ==
                          insertTreatmentInfoRequest
                              .treatmentInformations[i].medicineId)
                      .toList()[p]
                      .medicineInInventoryDetailId,
                  "Quantity": insertTreatmentInfoRequest
                      .treatmentInformationDetails
                      .where((e) =>
                          e.medicineId ==
                          insertTreatmentInfoRequest
                              .treatmentInformations[i].medicineId)
                      .toList()[p]
                      .quantity,
                };
              },
            ),
          };
        },
      ),
      'IsDelivered': insertTreatmentInfoRequest.isDelivered,
      'ConfirmSignatureImg':
          insertTreatmentInfoRequest.confirmSignatureImg != null
              ? await MultipartFile.fromFile(
                  insertTreatmentInfoRequest.confirmSignatureImg.path)
              : null
    });
    log(formData.fields.toString());
    return HttpService.put(APITREATMENTINFORMATION + "/" + treatmentId, null,
        data: formData, typeRequest: HttpService.FORMDATA, headers: header);
  }
// notification

  Future<ResponseServer> searchNotification(SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(
        APINOTIFICATIONSEARCH + params, NotificationListSearch.instance(),
        headers: header);
  }

  Future<ResponseServer> searchNotificationHistoryAction(
      SearchRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    String params = getParams(request);
    return HttpService.get(APINOTIFICATIONHISTORYACTIONSEARCH + params,
        NotificationListSearch.instance(),
        headers: header);
  }

  Future<ResponseServer> clickingNotification(
      NotifiClickRequest request) async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);

    return HttpService.put(APINOTIFICATIONCLICK, null,
        headers: header, data: request);
  }

// new update
  Future<ResponseServer> getNewVersionApp() async {
    String token = await GeneralHelper.getValueSharedPreferences("token");
    addHeader('Authorization', 'Bearer ' + token);
    return HttpService.get(APIGETAPP, AppVersion.instance(), headers: header);
  }
}
