import 'package:http/http.dart' as http;

String tag = "general";

class HisseService {
  static Future getNews(String tag) async {
    return await http.get(
        Uri.parse("https://api.collectapi.com/economy/hisseSenedi"),
        headers: {
          "authorization":
              'apikey 01gMdaauHzbp8e3uKwPWft:4JBJZySih6vC8FprvCw5QH',
          "content": 'application/json'
        });
  }
}

class AltinService {
  static Future getAltin() async {
    return await http.get(
        Uri.parse("https://api.collectapi.com/economy/goldPrice"),
        headers: {
          "authorization":
              'apikey 01gMdaauHzbp8e3uKwPWft:4JBJZySih6vC8FprvCw5QH',
          "content": 'application/json'
        });
  }
}

class DovizService {
  static Future getDoviz() async {
    return await http.get(
        Uri.parse("https://api.collectapi.com/economy/exchange"),
        headers: {
          "authorization":
              'apikey 01gMdaauHzbp8e3uKwPWft:4JBJZySih6vC8FprvCw5QH',
          "content": 'application/json'
        });
  }
}

class GasService {
  static Future getGass() async {
    return await http.get(
        Uri.parse(
            "https://api.collectapi.com/gasPrice/turkeyGasoline?city=istanbul"),
        headers: {
          "authorization":
              'apikey 01gMdaauHzbp8e3uKwPWft:4JBJZySih6vC8FprvCw5QH',
          "content": 'application/json'
        });
  }
}

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
