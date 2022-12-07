import 'dart:html';
import 'package:http/http.dart' as http;

class IpInfoApi {
  static Future<String?> getIPAddress() async {
    try {
      final Url = Uri.parse('http://api.ipinfy.org');
      final response = await http.get(Url);
      return response.statusCode == 200 ? response.body : null;
    } catch (e) {
      return null;
    }
  }
}
