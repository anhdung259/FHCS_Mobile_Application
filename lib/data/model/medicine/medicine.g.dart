// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medicine _$MedicineFromJson(Map<String, dynamic> json) {
  return Medicine(
    id: json['id'] as String,
    name: json['name'] as String,
    medicineUnitId: json['medicineUnitId'] as String,
    description: json['description'] as String,
    medicineSubgroupId: json['medicineSubgroupId'] as String,
    medicineClassificationId: json['medicineClassificationId'] as String,
    createDate: json['createDate'] as String,
    updateDate: json['updateDate'] as String,
    nameUnit: json['nameUnit'] as String,
    nameClassification: json['nameClassification'] as String,
    nameSubgroup: json['nameSubgroup'] as String,
    medicineUnit: json['medicineUnit'] == null
        ? null
        : MedicineUnit.fromJson(json['medicineUnit'] as Map<String, dynamic>),
    diagnostics: (json['diagnostics'] as List)
        ?.map((e) =>
            e == null ? null : Diagnostic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    contraindications: (json['contraindications'] as List)
        ?.map((e) => e == null
            ? null
            : Contraindications.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedicineToJson(Medicine instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'medicineUnitId': instance.medicineUnitId,
      'description': instance.description,
      'medicineSubgroupId': instance.medicineSubgroupId,
      'medicineClassificationId': instance.medicineClassificationId,
      'createDate': instance.createDate,
      'updateDate': instance.updateDate,
      'nameSubgroup': instance.nameSubgroup,
      'nameClassification': instance.nameClassification,
      'nameUnit': instance.nameUnit,
      'medicineUnit': instance.medicineUnit,
      'diseaseStatuses': instance.diagnostics,
      'contraindications': instance.contraindications,
    };
