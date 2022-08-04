
class ModelPersonalMain {
  bool status;
  ModelPersonal1 modelPersonal1;

  ModelPersonalMain({
    required this.status,
    required this.modelPersonal1,
  });

  factory ModelPersonalMain.fromMap(Map<String, dynamic> map) {
    return ModelPersonalMain(
      status: map['status'],
      modelPersonal1: ModelPersonal1.fromMap(map['data']),
    );
  }
}

class ModelPersonal1 {
  String firstname;
  String lastname;
  String bornedAt;
  String email;
  String phone;
  int countryType;
  int cityId;
  int jobId;
  int storeId;
  String shopAddress;

  ModelPersonal1({
    required this.firstname,
    required this.lastname,
    required this.bornedAt,
    required this.email,
    required this.phone,
    required this.countryType,
    required this.cityId,
    required this.jobId,
    required this.storeId,
    required this.shopAddress,
  });

  factory ModelPersonal1.fromMap(Map<String, dynamic> map) {
    return ModelPersonal1(
      firstname: map['firstname'],
      lastname: map['lastname'],
      bornedAt: map['borned_at'],
      email: map['email'],
      phone: map['phone'],
      countryType: map['country_type'],
      cityId: map['city_id'],
      jobId: map['job_id'],
      storeId: map['store_id'],
      shopAddress: map['shop_address'],
    );
  }
}
