import 'package:date_time_picker/date_time_picker.dart';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:flutter/material.dart';

class DatePick extends StatelessWidget {
  const DatePick({
    Key key,
    this.onChanged,
    this.dateNow,
    this.enableEdit = true,
    this.hintText = "Chọn ngày",
    this.backgroundColor = white,
    this.sizeWidth,
    this.dateInit,
    this.controller,
  }) : super(key: key);
  final ValueChanged<String> onChanged;
  final String dateNow;

  final DateTime dateInit;
  final bool enableEdit;
  final String hintText;
  final Color backgroundColor;
  final double sizeWidth;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      backgroundColor: backgroundColor,
      sizeWidth: sizeWidth ?? getProportionateScreenWidth(140),
      //  sizeheight: getProportionateScreenHeight(50),
      child: DateTimePicker(
          enabled: enableEdit,
          autovalidate: true,
          controller: controller,
          cursorColor: KPrimaryColor,
          locale: Locale('vi'),
          type: DateTimePickerType.date,
          enableSuggestions: true,
          initialDate: dateInit ?? null,
          initialValue: dateNow ?? null,
          dateMask: 'dd/MM/yyyy',
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.event,
              color: KPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
          // dateLabelText: 'Ngày',

          onChanged: onChanged),
    );
  }
}
