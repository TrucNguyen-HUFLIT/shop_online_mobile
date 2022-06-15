class RegisterModel {
  late String email;
  late String password;
  late String fullName;
  late String phoneNumber;
  late String address;

  RegisterModel(this.email, this.password, this.fullName, this.phoneNumber, this.address);

  RegisterModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['fullName'] = fullName;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    return data;
  }
}