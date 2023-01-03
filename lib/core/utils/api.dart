import 'package:http/http.dart' as http;

String tag = "general";

class NewsService {
  static Future getTech(String tag) async {
    return await http.get(
        Uri.parse(
            "https://api.collectapi.com/news/getNews?country=tr&tag=technology"),
        headers: {
          "authorization":
              'apikey 01gMdaauHzbp8e3uKwPWft:4JBJZySih6vC8FprvCw5QH',
          "content": 'application/json'
        });
  }
}

class IpSorgula {
  static Future ipSorgu() async {
    return await http.get(Uri.parse("https://api.ipify.org/?format=json"),
        headers: {"content": 'application/json'});
  }
}
