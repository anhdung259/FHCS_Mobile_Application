import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/data/provider/api_provider.dart';
import 'package:meta/meta.dart';

class SettingRepository {
  final ApiProvider apiClient;

  SettingRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseServer> getNewVersionApp() {
    return apiClient.getNewVersionApp();
  }
}
