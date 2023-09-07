// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/model/LoginModel.dart';

class HttpHelper {
  Loginmodel? LoginData;
  static var result;
  Future PostData(
      {required String choice,
      required String email,
      required String Password,
      String token = ""}) async {
    final url = Uri.parse("https://student.valuxapps.com/api/${choice}");
    http.Response response = await http.post(url,
        body: {"email": email, "password": Password},
        headers: {"lang": "en", "Authorization": token});
    result = json.decode(response.body);

    if (response.statusCode == 200) {
      try {
        LoginData = Loginmodel.fromMap(result);
        print(LoginData?.data?.email);
      } catch (e) {
        print(e);
        Get.snackbar("error", e.toString());
        //Get.showSnackbar(GetSnackBar());
      }
    }
  }
}
