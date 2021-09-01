import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:fhcs_mobile_application/widgets/Card/info_line.dart';
import 'package:fhcs_mobile_application/widgets/ScreenShared/background.dart';
import 'package:flutter/material.dart';

class BatchesMedicineRecordCard extends StatelessWidget {
  const BatchesMedicineRecordCard(
      {Key key,
      this.press,
      this.medicineName,
      this.quantity,
      this.unit,
      this.textStyle,
      this.price,
      this.status,
      this.dateExpiration,
      this.statusId})
      : super(key: key);
  final String medicineName;
  final Function press;
  final String quantity;
  final String price;
  final String unit;
  final String status;
  final int statusId;
  final String dateExpiration;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        press();
      },
      child: BackGroundCard(
        child: Padding(
          padding: EdgeInsets.symmetric(
              //vertical: getProportionateScreenHeight(5),
              horizontal: getProportionateScreenWidth(5)),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                MEDICAL_SUPPLIES,
                height: getProportionateScreenHeight(35),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DisplayInfo(
                    // title: "Dược phẩm: ",
                    info: medicineName,
                    textStyle: AppTheme.titleName,
                  ),
                  DisplayInfo(
                      title: "Số lượng: ",
                      info: quantity.toString() + " " + unit),
                  DisplayInfo(
                    title: "Đơn giá: ",
                    info: price,
                  ),
                  DisplayInfo(
                    title: "Hạn sử dụng: ",
                    info: dateExpiration,
                  ),
                  status != null
                      ? DisplayInfo(
                          title: "Trạng thái: ",
                          info: status,
                          textStyle: TextStyle(
                            color: GeneralHelper.checkDisplayColor(statusId),
                            fontSize: 16.5,
                            letterSpacing: 0.1,
                          ),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
