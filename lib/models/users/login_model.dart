class LoginModel {

  bool status;
  String message;
  UserData data;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']): null;

  }
}
class UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  //named constructor
  UserData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    id = json['name'];
    id = json['email'];
    id = json['phone'];
    id = json['image'];
    id = json['points'];
    id = json['credit'];
    id = json['token'];
  }
}