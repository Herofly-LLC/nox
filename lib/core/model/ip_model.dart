class IpSorguModel {
  late String ip;

  IpSorguModel(Map json) {
    ip = json['ip'] ?? "Hay aksi sorguda bir sorun oluştu!";
  }
}
