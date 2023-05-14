class User {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<String> addresses;
  String? newAddress;

  User(
    this.firstName,
    this.lastName,
    this.birthDate,
    this.addresses,
  );
}
