class CountryModel {
  bool status;
  CountryModelData data;
  CountryModel({
    required this.status,
    required this.data,
  });

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      status: map['status'],
      data: CountryModelData.fromMap(
        map['data'],
      ),
    );
  }
}

class CountryModelData {
  List<String> countries;
  CountryModelData({
    required this.countries,
  });

  factory CountryModelData.fromMap(Map<String, dynamic> map) {
    List<String> list = [];
    List<String> keys = [];
    for (var element in map.keys) {
      keys.add(element);
      list.add(map[element]);
    }
    return CountryModelData(
      countries: list,
    );
  }
}
