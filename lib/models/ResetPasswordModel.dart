class ResetPasswordModel {
  late String email;
  late String phoneNumber;

  ResetPasswordModel(this.email, this.phoneNumber);

  ResetPasswordModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}