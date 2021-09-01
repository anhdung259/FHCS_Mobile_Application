import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class LoginRepository {
  final ApiProvider apiClient;

  LoginRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> authUserGoogle(AuthRequest request) {
    return apiClient.authUserGoogle(request);
  }

  Future<ResponseServer> authUsernamePassword(AuthRequest request) {
    return apiClient.authUsernamePassword(request);
  }
}
