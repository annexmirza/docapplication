class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? gender;
  String? createdAt;
  String? profilePic;
  UserModel(
      {this.email,
      this.password,
      this.name,
      this.id,
      this.gender,
      this.profilePic});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] as String,
      profilePic: json['profile_pic'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
        'profile_pic': profilePic,
      };
}
