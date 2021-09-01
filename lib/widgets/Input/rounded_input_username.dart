import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:flutter/material.dart';

class RoundedUsernameField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isNumber;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedUsernameField({
    Key key,
    this.hintText,
    this.isNumber = false,
    this.icon,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      boxShawdow: true,
      borderColor: white,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: KPrimaryColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Hãy nhập tài khoản';
          }
          return null;
        },
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          // errorText:
          //     lc.isValidUserName.isFalse ? "Vui lòng nhập tài khoản" : null,
          icon: Icon(
            this.icon,
            color: darkText,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
