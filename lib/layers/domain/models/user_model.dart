class UserModel{
  String ?uid;
  String email;
  String password;
  String ?name;
  String ?phonenumber;


  UserModel({
    this.uid,
  required  this.email,
  required  this.password,
    this.name,
    this.phonenumber
  });
}