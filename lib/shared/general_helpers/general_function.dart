import 'package:fhcs_mobile_application/data/model/allergy/allergy.dart';
import 'package:fhcs_mobile_application/data/model/contraindications/contraindications.dart';
import 'package:fhcs_mobile_application/data/model/diagnostic/diagnostic.dart';
import 'package:fhcs_mobile_application/data/model/patient/patient.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/widgets/InsertDialog/insert_diagnostic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:get/get.dart';

import 'general_helper.dart';

class GeneralFunction {
  static ApiProvider apiProvider = new ApiProvider();
  static TextEditingController textIcdCodeController = TextEditingController();
  static TextEditingController textNameDiagnosticController =
      TextEditingController();
  static TextEditingController textDescriptionDiagnosticController =
      TextEditingController();

  static TextEditingController textNameContraindicationController =
      TextEditingController();
  static Map<String, ValueCompare> searchAllergy = {};
  static Map<String, ValueCompare> searchPatient = {};
  static Map<String, ValueCompare> searchValueDiagnostic = {};
  static Map<String, ValueCompare> searchValueCheckDuplicateDiagnostic = {};
  static Map<String, ValueCompare> searchValueContraindication = {};
  static var showNotifiDuplicateIcdCode = false.obs;
  static var showNotifiDuplicateNameDiagnostic = false.obs;
  static Future<Taggable> insertNewAllergy(dynamic insertNewAllergy) async {
    Allergy allergy;
    try {
      var result =
          await apiProvider.insertAllergy(Allergy(name: insertNewAllergy.name));
      if (result.statusCode == 201) {
        allergy = result.data;
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }

    return allergy;
  }

  static insertNewDiagnostic(
      String icdCode, String description, String name) async {
    try {
      var result = await apiProvider.insertDiagnostic(
          Diagnostic(name: name, description: description, icdCode: icdCode));
      if (result.statusCode == 201) {
        textIcdCodeController.clear();
        textDescriptionDiagnosticController.clear();
        textNameDiagnosticController.clear();
        Get.back();
        GeneralHelper.showMessage(msg: "Tạo thành công");
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<List<Allergy>> fetchAllergyList(String valueSearch) async {
    var listAllergy = <Allergy>[];
    print("object");
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchAllergy,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await apiProvider.fetchAllergy(SearchRequest(
        limit: 5,
        page: 1,
        sortOrder: 0,
        sortField: "Name",
        searchValue: searchAllergy,
        selectFields: "Id,Name"));
    if (result.statusCode == 200) {
      print("av");
      listAllergy = result.data.data;
      return listAllergy;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  static checkDuplicateIcdCode(String icdCode) async {
    searchValueCheckDuplicateDiagnostic.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "ICDCode",
        searchMap: searchValueCheckDuplicateDiagnostic,
        valueSearch: icdCode,
        compare: "Equals");
    var list = [];
    if (icdCode.isNotEmpty) {
      try {
        var result = await apiProvider.fetchDiagnostic(
            SearchRequest(
                limit: 1,
                page: 1,
                sortOrder: 0,
                sortField: "Name",
                searchValue: searchValueCheckDuplicateDiagnostic,
                selectFields: "Id,Name,icdCode"),
            "");
        if (result.statusCode == 200) {
          list = result.data.data;
          if (list.length > 0) {
            showNotifiDuplicateIcdCode(true);
          } else {
            showNotifiDuplicateIcdCode(false);
          }
        } else {
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  static checkDuplicateName(String name) async {
    searchValueCheckDuplicateDiagnostic.clear();
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueCheckDuplicateDiagnostic,
        valueSearch: name,
        compare: "Equals");
    var list = [];
    if (name.isNotEmpty) {
      try {
        var result = await apiProvider.fetchDiagnostic(
            SearchRequest(
                limit: 1,
                page: 1,
                sortOrder: 0,
                sortField: "Name",
                searchValue: searchValueCheckDuplicateDiagnostic,
                selectFields: "Id,Name,icdCode"),
            "");
        if (result.statusCode == 200) {
          list = result.data.data;
          if (list.length > 0) {
            showNotifiDuplicateNameDiagnostic(true);
          } else {
            showNotifiDuplicateNameDiagnostic(false);
          }
        } else {
          GeneralHelper.showMessage(msg: result.message);
        }
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  static showInsertNewDiagnostic() {
    GeneralHelper.showInsertNew(
        title: "Tạo mới chẩn đoán",
        pressOk: () => insertNewDiagnostic(
            textIcdCodeController.text,
            textDescriptionDiagnosticController.text,
            textNameDiagnosticController.text),
        clear: () {
          textIcdCodeController.clear();
          showNotifiDuplicateIcdCode(false);
          textDescriptionDiagnosticController.clear();
          showNotifiDuplicateNameDiagnostic(false);
        },
        content: InsertDiagnostic(
          // listSelected: [],
          nameDiagnostic: textNameDiagnosticController,
          icdCodecontroller: textIcdCodeController,
          desController: textDescriptionDiagnosticController,
        ));
  }

  static Future<List<Patient>> fetchPatientList(String valueSearch) async {
    var listPatient = <Patient>[];
    GeneralHelper.updateSearchMap(
        fieldSearch: "internalCode",
        searchMap: searchPatient,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await apiProvider.fetchPatient(SearchRequest(
        limit: 5,
        page: 1,
        sortOrder: 1,
        searchValue: searchPatient,
        selectFields:
            "id,internalCode,name,gender,department.id as departmentId"));
    if (result.statusCode == 200) {
      listPatient = result.data.data;
      return listPatient;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  static Future<List<Diagnostic>> fetchDiagnosticList(
      String valueSearch) async {
    var listDiagnostic = <Diagnostic>[];
    var result = await apiProvider.fetchDiagnostic(
        SearchRequest(
            limit: 5,
            page: 1,
            sortOrder: 0,
            sortField: "Name",
            searchValue: searchValueDiagnostic,
            selectFields: "Id,Name,icdCode"),
        valueSearch);
    // print("aaaaa" + result.data.data);
    if (result.statusCode == 200) {
      listDiagnostic = result.data.data;
      return listDiagnostic;
    } else {
      GeneralHelper.showMessage(msg: result.message);
      return [];
    }
  }

  static Future<List<Contraindications>> fetchContraindicationList(
      String valueSearch) async {
    var listContraindication = <Contraindications>[];
    GeneralHelper.updateSearchMap(
        fieldSearch: "Name",
        searchMap: searchValueContraindication,
        valueSearch: valueSearch,
        compare: "Contains");

    var result = await apiProvider.fetchContraindications(SearchRequest(
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
}
