class RegistrationEntity {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phoneNumber;

  RegistrationEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phoneNumber,
  });
}
