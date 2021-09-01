class FilterObject {
  dynamic display;
  dynamic id;
  @override
  String toString() => display;
  bool isEqual(FilterObject model) {
    return this?.id == model?.id;
  }

  FilterObject({this.display, this.id});
}
