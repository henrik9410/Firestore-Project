class UserModel {
  String? id;
  String? name;
  String? surname;
  String? middleName;
  UserModel({
    this.id,
    this.name,
    this.surname,
    this.middleName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    middleName = json['middleName'];
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['surname'] = surname;
    data['middleName'] = middleName;
    return data;
  }
}
