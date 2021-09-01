import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'background_text_field.dart';

class AutoCompleteTextField extends StatelessWidget {
  const AutoCompleteTextField({
    Key key,
    this.controller,
    this.itemBuilder,
    this.suggestionsCallback,
    this.onSuggestionSelected,
    this.hintText = SEARCHFIELDMEDICINE,
    this.icon,
    this.focus = true,
  }) : super(key: key);

  final hintText;
  final TextEditingController controller;
  final Function(BuildContext, dynamic) itemBuilder;
  final Future<Iterable<dynamic>> Function(String) suggestionsCallback;
  final Function(dynamic) onSuggestionSelected;
  final Widget icon;
  final bool focus;
  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      child: TypeAheadField(
          hideSuggestionsOnKeyboardHide: false,
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: focus,
            style: AppTheme.infoPrescription,
            controller: controller,
            // inputFormatters: [

            // ],
            decoration: InputDecoration(
              prefixIcon: icon ??
                  Icon(
                    Icons.search,
                    color: KPrimaryColor,
                  ),
              border: InputBorder.none,
              hintText: hintText,
            ),
          ),
          transitionBuilder: (context, suggestionsBox, animationController) =>
              FadeTransition(
                child: suggestionsBox,
                opacity: CurvedAnimation(
                    parent: animationController, curve: Curves.fastOutSlowIn),
              ),
          hideOnEmpty: true,
          getImmediateSuggestions: true,
          suggestionsCallback: suggestionsCallback,
          itemBuilder: itemBuilder,
          noItemsFoundBuilder: (context) => Container(
                height: 100,
                child: Center(
                  child: Text(
                    'Không tìm thấy dược phẩm nào',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
          onSuggestionSelected: onSuggestionSelected),
    );
  }
}
