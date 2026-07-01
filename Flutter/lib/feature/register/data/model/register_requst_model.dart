// feature/register/data/model/register_requst_model.dart
class RegisterRequestModel {
  RegisterRequestModel({
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.roleID,
  });

  final String userName;
  final String email;
  final String password;
  final String phoneNumber;
  final int roleID;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      userName: json['UserName']?.toString() ?? '',
      email: json['Email']?.toString() ?? '',
      password: json['Password']?.toString() ?? '',
      phoneNumber: json['PhoneNumber']?.toString() ?? '',
      roleID: json['RoleID'] is int
          ? json['RoleID'] as int
          : int.tryParse(json['RoleID']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Email': email,
      'Password': password,
      'PhoneNumber': "+2$phoneNumber",
      'RoleID': roleID,
    };
  }
}
