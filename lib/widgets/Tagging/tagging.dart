import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/widgets/Input/background_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';

class Tagging extends StatelessWidget {
  const Tagging({
    Key key,
    this.list,
    this.focus,
    this.findSuggestions,
    this.additionCallback,
    this.onAdded,
    this.hintText,
    this.textButton,
    this.function,
  }) : super(key: key);
  final List<dynamic> list;
  final FocusNode focus;
  final Future<List<Taggable>> Function(String) findSuggestions;
  final Function(String) additionCallback;
  final Future<Taggable> Function(dynamic) onAdded;
  final String hintText;
  final String textButton;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      child: FlutterTagging<Taggable>(
        emptyBuilder: (context) {
          return Container(
              height: 100, child: Center(child: Text("Không tìm thấy")));
        },
        initialItems: list,
        textFieldConfiguration: TextFieldConfiguration(
          focusNode: focus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
            border: InputBorder.none,
            filled: true,
            fillColor: white,
            hintText: hintText,
            labelText: 'Chọn',
          ),
        ),
        findSuggestions: findSuggestions,
        additionCallback: additionCallback,
        onAdded: onAdded,
        configureSuggestion: (dynamic object) {
          return SuggestionConfiguration(
            title: Text(object.name),
            // subtitle: Text(disease.description.toString()),

            additionWidget: Chip(
              avatar: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              label: Text(textButton),
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
              ),
              backgroundColor: KPrimaryColor,
            ),
          );
        },
        configureChip: (dynamic object) {
          return object != null
              ? ChipConfiguration(
                  label: Text(object.name),
                  backgroundColor: KPrimaryColor,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                )
              : ChipConfiguration(label: Text(""));
        },
        onChanged: () {
          list.removeWhere((element) => element == null);
          function?.call();
        },
      ),
    );
  }
}

class TaggingInsertDialog extends StatelessWidget {
  const TaggingInsertDialog({
    Key key,
    this.list,
    this.focus,
    this.findSuggestions,
    this.additionCallback,
    this.onAdded,
    this.hintText,
    this.textButton,
    this.function,
    this.controller,
  }) : super(key: key);
  final List<dynamic> list;
  final FocusNode focus;
  final Future<List<Taggable>> Function(String) findSuggestions;
  final Function(String) additionCallback;
  final Future<Taggable> Function(dynamic) onAdded;
  final String hintText;
  final String textButton;
  final Function function;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      child: FlutterTagging<Taggable>(
        emptyBuilder: (context) {
          return Container(
              height: 100, child: Center(child: Text("Không tìm thấy")));
        },
        initialItems: list,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
            border: InputBorder.none,
            filled: true,
            fillColor: white,
            hintText: hintText,
            labelText: 'Chọn',
          ),
        ),
        findSuggestions: findSuggestions,
        additionCallback: additionCallback,
        onAdded: onAdded,
        configureSuggestion: (dynamic object) {
          return SuggestionConfiguration(
            title: Text(object.name),

            // subtitle: Text(disease.description.toString()),

            additionWidget: InkWell(
              onTap: function,
              child: Chip(
                avatar: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                label: Text(textButton),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
                backgroundColor: KPrimaryColor,
              ),
            ),
          );
        },
        configureChip: (dynamic object) {
          return object != null
              ? ChipConfiguration(
                  label: Text(object.name),
                  backgroundColor: KPrimaryColor,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                )
              : ChipConfiguration(label: Text(""));
        },
        onChanged: () {
          list.removeWhere((element) => element == null);
        },
      ),
    );
  }
}

class TaggingInsertDiagnosticDialog extends StatelessWidget {
  const TaggingInsertDiagnosticDialog({
    Key key,
    this.list,
    this.focus,
    this.findSuggestions,
    this.additionCallback,
    this.onAdded,
    this.hintText,
    this.textButton,
    this.insertFunction,
    this.controller,
    this.onChangedFunction,
  }) : super(key: key);
  final List<dynamic> list;
  final FocusNode focus;
  final Future<List<Taggable>> Function(String) findSuggestions;
  final Function(String) additionCallback;
  final Future<Taggable> Function(dynamic) onAdded;
  final String hintText;
  final String textButton;
  final Function insertFunction;
  final Function onChangedFunction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BackGroundTextField(
      child: FlutterTagging<Taggable>(
        emptyBuilder: (context) {
          return Container(
              height: 100, child: Center(child: Text("Không tìm thấy")));
        },
        initialItems: list,
        textFieldConfiguration: TextFieldConfiguration(
          controller: controller,
          focusNode: focus,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(15, 8, 0, 8),
            border: InputBorder.none,
            filled: true,
            fillColor: white,
            hintText: hintText,
            labelText: 'Chọn',
          ),
        ),
        findSuggestions: findSuggestions,
        additionCallback: additionCallback,
        onAdded: onAdded,
        configureSuggestion: (dynamic object) {
          return SuggestionConfiguration(
            title: object.icdCode != null
                ? object.icdCode != ""
                    ? Text(object.icdCode + " - " + object.name)
                    : Text(object.name)
                : Text(object.name),

            // subtitle: Text(disease.description.toString()),

            additionWidget: InkWell(
              onTap: insertFunction,
              child: Chip(
                avatar: Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ),
                label: Text(textButton),
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300,
                ),
                backgroundColor: KPrimaryColor,
              ),
            ),
          );
        },
        configureChip: (dynamic object) {
          return object != null
              ? ChipConfiguration(
                  label: object.icdCode != null
                      ? object.icdCode != ""
                          ? Text(object.icdCode + " - " + object.name)
                          : Text(object.name)
                      : Text(object.name),
                  backgroundColor: KPrimaryColor,
                  labelStyle: TextStyle(color: Colors.white),
                  deleteIconColor: Colors.white,
                )
              : ChipConfiguration(label: Text(""));
        },
        onChanged: () {
          list.removeWhere((element) => element == null);
          onChangedFunction?.call();
        },
      ),
    );
  }
}
