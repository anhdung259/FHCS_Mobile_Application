import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fhcs_mobile_application/data/model/response/response_server/response_server.dart';
import 'package:fhcs_mobile_application/shared/general_helpers/general_helper.dart';

//Use this class to call API Server
class HttpService {
  static const String FORMBODY = "FormBody";
  static const String FORMDATA = "FormData";
  static Dio dio = new Dio();
  static bool check = true;
  static Future<ResponseServer> get(url, responseDataInstance,
      {Map<String, String> headers}) async {
    //headers.remove("content-type");
    log(url);
    Response res = await dio.get(url,
        options: new Options(
          headers: headers, followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ));

    if (res.statusCode == 200) {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              data: res.data["data"],
              message: res.data["message"],
              statusCode: res.data["statusCode"]);
      responseServer.data = responseDataInstance.fromJson(responseServer.data);
      return responseServer;
    } else if (res.statusCode == 423) {
      GeneralHelper.showAccountDeActive();
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      return responseServer;
    } else {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      print(responseServer.message);
      return responseServer;
    }
  }

  // ignore: missing_return
  static Future<ResponseServer> post(url, responseDataInstance,
      {Map<String, String> headers,
      data,
      typeRequest,
      Encoding encoding}) async {
    Response res;
    print(url);
    if (typeRequest == FORMBODY || typeRequest == null) {
      headers['content-type'] = 'application/json';
      print(jsonEncode(data.toJson()));
      res = await dio.post(
        url,
        data: jsonEncode(data.toJson()),
        options: new Options(
          headers: headers, followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );
    } else {
      headers['content-type'] = 'multipart/form-data';
      //Map<String,dynamic> dataFormData = encode(data);
      //FormData formData = new FormData.fromMap(dataFormData);

      print(url);
      res = await dio.post(
        url,
        data: data,
        options: new Options(
          headers: headers, followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );
    }

    if (res.statusCode == 200 || res.statusCode == 201) {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              data: res.data["data"],
              message: res.data["message"],
              statusCode: res.data["statusCode"]);
      if (responseDataInstance == null) {
        return responseServer;
      }

      if (responseServer.data != null) {
        responseServer.data =
            responseDataInstance.fromJson(responseServer.data);
        return responseServer;
      }
    } else if (res.statusCode == 423) {
      GeneralHelper.showAccountDeActive();
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      return responseServer;
    } else {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      print(responseServer.message + "|" + url);
      return responseServer;
    }
  }

  static Future<ResponseServer> put(url, responseDataInstance,
      {Map<String, String> headers,
      data,
      typeRequest,
      Encoding encoding}) async {
    //headers.remove("content-type");
    Response res;
    print(url);
    if (typeRequest == FORMBODY || typeRequest == null) {
      headers['content-type'] = 'application/json';
      //response = await http.put(url, headers: headers, body: jsonEncode(data.toJson()), encoding: encoding);
      print(url);
      print(jsonEncode(data.toJson()));
      res = await dio.put(url,
          data: jsonEncode(data.toJson()),
          options: new Options(
            headers: headers, followRedirects: false,
            // will not throw errors
            validateStatus: (status) => true,
          ));
    } else {
      headers['content-type'] = 'multipart/form-data';
      res = await dio.put(
        url,
        data: data,
        options: new Options(
          headers: headers, followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
        ),
      );
    }
    if (res.statusCode == 200 || res.statusCode == 201) {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              data: res.data["data"],
              message: res.data["message"],
              statusCode: res.data["statusCode"]);
      //ResponseServer.fromJson(json.decode(res.));
      if (responseDataInstance == null) {
        return responseServer;
      } else {
        responseServer.data =
            responseDataInstance.fromJson(responseServer.data);
        return responseServer;
      }
    } else if (res.statusCode == 423) {
      GeneralHelper.showAccountDeActive();
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      return responseServer;
    } else {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      print(responseServer.message + "|" + url);
      return responseServer;
    }
  }

  static Future<ResponseServer> delete(url,
      {Map<String, String> headers}) async {
    print("url" + url);
    final res = await dio.delete(
      url,
      options: new Options(
        headers: headers, followRedirects: false,
        // will not throw errors
        validateStatus: (status) => true,
      ),
    );
    if (res.statusCode == 200) {
      //headers.remove("content-type");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      return responseServer;
    } else if (res.statusCode == 423) {
      GeneralHelper.showAccountDeActive();
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      return responseServer;
    } else {
      ResponseServer responseServer = //decode<ResponseServer>(res.data);
          new ResponseServer(
              message: res.data["message"], statusCode: res.data["statusCode"]);
      print(responseServer.message + "|" + url);
      return responseServer;
    }
  }
}
