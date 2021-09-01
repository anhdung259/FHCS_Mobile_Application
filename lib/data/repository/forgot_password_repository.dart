import 'package:fhcs_mobile_application/data/model/requests/auth_request/auth_request.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class ForgotPasswordRepository {
  final ApiProvider apiClient;

  ForgotPasswordRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<ResponseServer> sendCode(AuthRequest request) {
    return apiClient.sendCode(request);
  }

  Future<ResponseServer> verifyCodeAccount(AuthRequest request) {
    return apiClient.verifyCodeAccount(request);
  }

  Future<ResponseServer> changeForgotPassword(AuthRequest request) {
    return apiClient.changeForgotPassword(request);
  }
}
