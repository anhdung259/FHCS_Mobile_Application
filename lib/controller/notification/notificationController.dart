import 'package:fhcs_mobile_application/controller/account/account_controller.dart';
import 'package:fhcs_mobile_application/data/model/notificationSearch/notificationSearch.dart';
import 'package:fhcs_mobile_application/data/model/paging/info.dart';
import 'package:fhcs_mobile_application/data/model/requests/notifi_click_request/notifi_click_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/request_search/request_search.dart';
import 'package:fhcs_mobile_application/data/model/valueCompare/value_compare.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:fhcs_mobile_application/data/repository/account_repository.dart';
import 'package:fhcs_mobile_application/data/repository/notification_repository.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class NotificationController extends GetxController {
  final NotificationRepository repository;
  NotificationController({@required this.repository})
      : assert(repository != null);
  var listPaginationNotification =
      List<NotificationSearch>.empty(growable: true).obs;
  var listPaginationHistoryAction =
      List<NotificationSearch>.empty(growable: true).obs;
  var isLoading = true.obs;
  var isLoadingHistoryAction = true.obs;
  var isMoreDataAvailable = true.obs;
  var isMoreDataHistoryActionAvailable = true.obs;
  var currentPage = 1;
  var pageSize = 10;
  var pagingloading = false.obs;
  var info = Info().obs;
  var loadingWait = false.obs;
  var numNotificationNotSeen = 0.obs;
  var currentIndex = 0.obs;
  var isClick = false.obs;
  Map<String, ValueCompare> searchValueActionHistory = {};
  AccountController ac = Get.put(AccountController(
      accountRepository: AccountRepository(apiClient: ApiProvider())));

  @override
  void onInit() {
    fetchNotifiList();
    super.onInit();
  }

  void refreshList() async {
    listPaginationNotification.clear();
    fetchNotifiHistoryActionList();
    fetchNotifiList();
  }

  void pagingNotifiList() {
    GeneralHelper.paging(
        info: info,
        listPagination: listPaginationNotification,
        isMoreDataAvailable: isMoreDataAvailable,
        limit: pageSize,
        sortField: "createAt",
        sortOrder: 1,
        searchFuntion: repository.searchNotification);
  }

  void fetchNotifiList() async {
    isLoading(true);
    isMoreDataAvailable(true);
    listPaginationNotification.clear();

    try {
      var result = await repository.searchNotification(SearchRequest(
        limit: pageSize,
        page: 1,
        sortOrder: 1,
        sortField: "createAt",
      ));
      if (result.statusCode == 200) {
        info.value = result.data.info;
        numNotificationNotSeen.value = info.value.totalRecord;
        print("notseen" + info.value.totalRecord.toString());
        listPaginationNotification.addAll(result.data.data);
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void pagingNotifiHistoryAction() {
    GeneralHelper.paging(
        info: info,
        listPagination: listPaginationHistoryAction,
        isMoreDataAvailable: isMoreDataHistoryActionAvailable,
        limit: pageSize,
        sortOrder: 1,
        sortField: "createAt",
        searchValue: searchValueActionHistory,
        searchFuntion: repository.searchNotificationHistoryAction);
  }

  updateValueSearchHistoryAction() {
    GeneralHelper.updateSearchMap(
        fieldSearch: "accountIdsCanView",
        searchMap: searchValueActionHistory,
        valueSearch: ac.accountId,
        compare: "Equals");
  }

  void fetchNotifiHistoryActionList() async {
    isLoadingHistoryAction(true);
    isMoreDataHistoryActionAvailable(true);
    listPaginationHistoryAction.clear();
    updateValueSearchHistoryAction();

    try {
      var result =
          await repository.searchNotificationHistoryAction(SearchRequest(
        limit: pageSize,
        page: 1,
        sortOrder: 1,
        searchValue: searchValueActionHistory,
        sortField: "createAt",
      ));
      if (result.statusCode == 200) {
        info.value = result.data.info;
        listPaginationHistoryAction.addAll(result.data.data);
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      isLoadingHistoryAction(false);
    }
  }

  void notificationClick(String notifiId) async {
    try {
      var result = await repository
          .clickingNotification(NotifiClickRequest(notificationId: notifiId));
      if (result.statusCode == 200) {
        listPaginationNotification
            .singleWhere((e) => e.data.notificationId == notifiId)
            .isClicked = true;
        listPaginationNotification.refresh();
        // isClick(false);
        listPaginationNotification.refresh();
      } else {
        GeneralHelper.showMessage(msg: result.message);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
