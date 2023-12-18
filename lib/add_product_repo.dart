import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

//_________ADD_NEW_PRODUCT__________________________________________________
Future<bool> addProduct({required File imageFile, required String name, required String code}) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse('URL'));
    request.fields.addAll({
      "name":name,
      "code":code,
    });
    request.fields['name'] = name;
    request.fields['code'] = code;

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    request.headers.addAll({'Accept': 'application/json', 'Authorization': 'Bearer HFEGYWGDYWDG'});
    var response = await request.send();
    var res = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      return true;
    } else {
      var data = jsonDecode(res.body);
      // EasyLoading.showError(data['message']);
      return false;
    }
  } catch (e) {
    // EasyLoading.showError(e.toString());
    throw Exception('Error');
  }
}
