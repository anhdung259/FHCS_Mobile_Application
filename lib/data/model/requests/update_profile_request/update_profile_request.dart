import 'dart:io';

class UpdateProfileRequest {
  String phoneNumber;
  String description;
  String displayName;
  File avatarFile;

  UpdateProfileRequest(
      {this.phoneNumber, this.displayName, this.avatarFile, this.description});
}
