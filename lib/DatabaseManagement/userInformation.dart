class User{
  int? id;
  String name;
  String email;
  late String passwordHash;



  User({this.id, required this.name, required this.email, required this.passwordHash});

  User.newPassword({this.id, required this.name, required this.email, required password}){
    passwordHash= hashPassword(password);
  }




  static String hashPassword(password) {
    return password.hashCode.toString();
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'passwordHash': passwordHash,
    };
  }

  bool checkPassword(String password){
    return passwordHash==hashPassword(password);
  }

  static User fromJson(Map<String, dynamic> userMap) {
    return User(
      id: userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
      passwordHash: userMap['passwordHash'],
    );
  }

}