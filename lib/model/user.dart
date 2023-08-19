class User {
  final int userId;
  final String email;
  final String name;
  final String password;
  final String phoneNumber;
  final String address;
  final String role;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userData = json['data'][0];
    return User(
      userId: int.parse(userData['user_id']),
      email: userData['email'],
      name: userData['nama'],
      password: userData['password'],
      phoneNumber: userData['telp'],
      address: userData['alamat'],
      role: userData['role'],
    );
  }
}
