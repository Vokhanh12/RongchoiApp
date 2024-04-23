import 'package:rongchoi_app/domain/entities/api.dart';

enum UserRole {
  buyer,
  seller,
  employee,
}

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firstName;
  final String lastName;
  final String email;
  final String nickName;
  final String numberPhone;
  final DateTime dateOfBirth;
  final String address;
  final UserRole role;
 
  User(
      this.id,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.email,
      this.nickName,
      this.address,
      this.dateOfBirth,
      this.numberPhone,
      this.role,

      );

  User.fromUser(User user)
      : id = user.id,
        createdAt = user.createdAt,
        updatedAt = user.updatedAt,
        firstName = user.firstName,
        lastName = user.lastName,
        email = user.email,
        nickName = user.nickName,
        numberPhone = user.numberPhone,
        dateOfBirth = user.dateOfBirth,
        address = user.address,
        role = user.role;

  User.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        createdAt = DateTime.parse(map['created_at']),
        updatedAt = DateTime.parse(map['updated_at']),
        firstName = map['first_name'],
        lastName = map['last_name'],
        email = map['email'],
        nickName = map['nick_name']['String'], // Assuming nick_name is a String
        numberPhone = map['number_phone'],
        dateOfBirth = DateTime.parse(
            map['day_of_birth']['Time']), // Parsing nested time string
        address = map['address']['String'], // Assuming address is a String
        role = UserRole.values
            .firstWhere((e) => e.toString().split('.').last == map['role']);

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'nick_name': nickName,
        'number_phone': numberPhone,
        'date_of_birth': dateOfBirth.toIso8601String(),
        'address': address,
        'role': role.toString().split('.').last,
      };

  /// Convert [this] to a Json `Map<String, String>`. All complex structures
  /// are also converted to `String`.
  /*
  Map<String, String> toJson2() => {
        'firstName': firstName,
        'lastName': lastName,
        'uid': uid,
        'email': email
      };
   */
}
