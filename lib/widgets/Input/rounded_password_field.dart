import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String passwordConfirm;
  final bool showIcon;
  final bool showShadow;
  final Color borderColor;
  const RoundedPasswordField(
      {Key key,
      this.hintText,
      this.onChanged,
      this.controller,
      this.passwordConfirm,
      this.showIcon = true,
      this.borderColor = white,
      this.showShadow = false})
      : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  // Toggles the password show status
  void toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      borderColor: widget.borderColor,
      boxShawdow: widget.showShadow,
      child: TextFormField(
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        controller: widget.controller,
        cursorColor: KPrimaryColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Hãy nhập mật khẩu';
          } else if (widget.passwordConfirm != null) {
            if (value != widget.passwordConfirm) {
              return 'Mật khẩu không trùng nhau';
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: this.widget.hintText,
          // errorText: lc.isValidPass.isFalse ? "Vui lòng nhập mật khẩu" : null,
          icon: widget.showIcon
              ? Icon(
                  Icons.lock,
                  color: dark_grey,
                )
              : null,
          suffixIcon: InkWell(
            onTap: () {
              toggle();
            },
            child: _obscureText
                ? Icon(
                    Icons.visibility_off,
                    color: grey,
                  )
                : Icon(
                    Icons.visibility,
                    color: grey,
                  ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
