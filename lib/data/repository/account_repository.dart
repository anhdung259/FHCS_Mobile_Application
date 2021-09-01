import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/model/requests/update_profile_request/update_profile_request.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class AccountRepository {
  final ApiProvider apiClient;

  AccountRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> getProfileInfo() {
    return apiClient.getProfileInfo();
  }

  Future<ResponseServer> updateProfile() {
    return apiClient.updateProfile();
  }

  Future<ResponseServer> updateProfileUser(
      UpdateProfileRequest updateProfileRequest) {
    return apiClient.updateProfileUser(updateProfileRequest);
  }

  Future<ResponseServer> changeNewPassword(AuthRequest request) {
    return apiClient.changeNewPassword(request);
  }
}
