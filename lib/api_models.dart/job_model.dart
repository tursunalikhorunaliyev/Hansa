class JobModel {
  bool status;
  JobModelData data;
  JobModel({
    required this.status,
    required this.data,
  });

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      status: map['status'] as bool,
      data: JobModelData.fromMap(map['data']),
    );
  }
}

class JobModelData {
  List<String> jobs;
  JobModelData({
    required this.jobs,
  });

  factory JobModelData.fromMap(Map<String, dynamic> map) {
    List<String> list = [];
    List<String> keys = [];
    for (var element in map.keys) {
      keys.add(element);
      list.add(map[element]);
    }
    return JobModelData(
      jobs: list,
    );
  }
}
