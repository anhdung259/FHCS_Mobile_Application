import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@JsonSerializable()
class Account {
  String id;
  String internalCode;
  String phoneNumber;
  String email;
  String photoUrl;
  String description;
  String displayName;
  String token;

  Account(
      {this.id,
      this.internalCode,
      this.phoneNumber,
      this.email,
      this.photoUrl,
      this.displayName,
      this.token,
      this.description});
  Account.instance();
  Account fromJson(Map<String, dynamic> json) {
    return _$AccountFromJson(json);
  }

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
