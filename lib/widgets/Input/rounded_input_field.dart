import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'background_text_field.dart';

class RoundedInputField extends StatefulWidget {
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon,
      this.isNumber = false,
      this.onChanged,
      this.controller,
      this.line = 1,
      this.suffixText,
      this.textInputFormat,
      this.sizeWidth,
      this.validate,
      this.enableEdit = true,
      this.backGroundColor = white,
      this.borderColor = grey,
      this.textInputAction,
      this.press,
      this.sizeHeight,
      this.applyBoxShadow = false,
      this.onSearch = false,
      this.error})
      : super(key: key);

  final String hintText;
  final Widget icon;
  final bool isNumber;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final int line;
  final String suffixText;
  final List<TextInputFormatter> textInputFormat;
  final double sizeWidth;
  final double sizeHeight;
  final ValueChanged<String> validate;
  final bool enableEdit;
  final Color backGroundColor;
  final Color borderColor;
  final TextInputAction textInputAction;
  final Function press;
  final bool applyBoxShadow;
  final bool onSearch;
  final String error;

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  bool _wasEmpty;
  @override
  void initState() {
    super.initState();
    _wasEmpty = widget.controller.text.isEmpty;
    widget.controller.addListener(() {
      if (_wasEmpty != widget.controller.text.isEmpty) {
        if (this.mounted) {
          // check whether the state object is in tree
          setState(() {
            _wasEmpty = widget.controller.text.isEmpty;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      sizeWidth: widget.sizeWidth,
      sizeheight: widget.sizeHeight,
      backgroundColor: widget.backGroundColor,
      borderColor: widget.borderColor,
      boxShawdow: widget.applyBoxShadow,
      child: TextFormField(
          onFieldSubmitted: widget.onChanged,
          //textInputAction: widget.textInputAction,
          maxLines: widget.line,
          controller: widget.controller,
          keyboardType:
              widget.isNumber ? TextInputType.number : TextInputType.text,
          inputFormatters: widget.textInputFormat,
          validator: widget.validate,
          onChanged: widget.onChanged,
          enabled: widget.enableEdit,
          cursorColor: KPrimaryColor,
          style: AppTheme.normalText,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: widget.icon != null ? widget.icon : null,
            errorText: widget.error,
            suffixText: widget.suffixText ?? null,
            suffixIcon:
                widget.controller.text.isNotEmpty && widget.isNumber == false
                    ? IconButton(
                        iconSize: 17.0,
                        icon: Icon(
                          Icons.cancel,
                          color: grey,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.controller.clear();
                            // print(widget.controller.text);
                          });
                          if (widget.onSearch == true) {
                            widget.press();
                          }
                        },
                      )
                    : null,
          )),
    );
  }
}
