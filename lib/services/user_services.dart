import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {
  static Future<List<String>> getusers() async {
    try {
      var usrData = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/users"))
          .timeout(Duration(seconds: 5));
      if (usrData.statusCode == 200) {
        var jsonData = jsonDecode(usrData.body);
        List<String> users = [];
        for (var usr in jsonData) {
          users.add(usr['email']);
        }
        users.add('deso@1.com');
        print(users);
        return users;
      } else
        return [];
    } catch (e) {
      print("in get users_function (${e})");
      return [];
    }
  }
}
