// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_list_department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentList _$DepartmentListFromJson(Map<String, dynamic> json) {
  return DepartmentList(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Department.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DepartmentListToJson(DepartmentList instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
