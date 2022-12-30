class HaberModel {
  late String name;
  late String url;
  late String description;
  late String date;

  HaberModel(Map json) {
    name = json['name'] ?? "Hay aksi bir sorun oluştu!";
    url = json['url'] ?? "Hay aksi bir sorun oluştu!";
    description = json['description'] ?? "Hay aksi bir sorun oluştu!";
    date = json['date'] ?? "Hay aksi bir sorun oluştu!";
  }
}
