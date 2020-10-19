class UserModel{
  int id;
  String username;
  String email;

  UserModel({this.id, this.username, this.email});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      username: json['name'],
      email: json['email']
    );
  }

}