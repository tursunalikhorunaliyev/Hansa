class StoreModel {
  bool status;
  StoreModelData data;
  StoreModel({
    required this.status,
    required this.data,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      status: map['status'] as bool,
      data: StoreModelData.fromMap(
        map['data'],
      ),
    );
  }
}

class StoreModelData {
  List<String> stores;
  StoreModelData({
    required this.stores,
  });

  factory StoreModelData.fromMap(Map<String, dynamic> map) {
    List<String> list = [];
    List<String> keys = [];
    for (var element in map.keys) {
      keys.add(element);
      list.add(map[element]);
    }
    return StoreModelData(
      stores: list,
    );
  }
}
