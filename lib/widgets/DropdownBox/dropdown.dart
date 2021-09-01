import 'package:dropdown_search/dropdown_search.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/widgets/Input/boxInsertNew.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  Dropdown(
      {Key key,
      // this.list,
      this.obj,
      this.idDropDown,
      this.itemSelected,
      this.showClearButton = true,
      this.title,
      this.press,
      this.functionSearch,
      this.listItem,
      this.textController})
      : super(key: key);
  // RxList<dynamic> list;
  final dynamic obj;
  RxString idDropDown;
  String itemSelected;
  final bool showClearButton;
  final String title;
  final Function press;
  final TextEditingController textController;
  List listItem;
  final Future<List<dynamic>> Function(String) functionSearch;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //  boxShadow: kElevationToShadow[1],
        border: Border.all(
            color: grey, // set border color
            width: 1), // set border width
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)), // set rounded corner radius
      ),
      child: DropdownSearch<dynamic>(
        clearButton: Icon(Icons.close),
        showClearButton: showClearButton,
        items: functionSearch == null ? listItem : [],
        isFilteredOnline: true,
        onFind: functionSearch,
        searchBoxController: textController,
        showSelectedItem: true,
        compareFn: (obj, select) => obj.isEqual(select),
        dropdownBuilderSupportsNullItem: true,
        emptyBuilder: (context, string) => Container(
          child: Center(
            child: Text(
              'Không tìm thấy',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
        ),
        onChanged: (obj) {
          if (obj != null) {
            idDropDown.value = obj.id;
            // itemSelected = obj.name;

          } else {
            idDropDown.value = "";
            itemSelected = "";
          }
        },
        selectedItem: itemSelected.isEmpty || itemSelected == null
            ? null
            : listItem.firstWhere((e) => e.id == itemSelected),
        popupSafeArea: PopupSafeArea(top: true, bottom: true),
        mode: Mode.DIALOG,
        maxHeight: 400,
        searchBoxDecoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
          labelText: "tìm kiếm",
        ),
        popupTitle: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: KPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? "",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: Get.back,
                      child: Icon(
                        Icons.clear,
                        color: white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            press != null
                ? BoxInsertNew(
                    press: () {
                      press();
                    },
                  )
                : Container()
          ],
        ),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        label: "Chọn",
        showSearchBox: true,
      ),
    );
  }
}
