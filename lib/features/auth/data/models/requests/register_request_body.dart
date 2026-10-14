class RegisterRequestBody {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const RegisterRequestBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
  };

  // Splits a single full name string into firstName and lastName.
  // Everything after the first space becomes lastName; single-word names use empty string.
  factory RegisterRequestBody.fromFullName({
    required String fullName,
    required String email,
    required String password,
  }) {
    final trimmedFullName = fullName.trim();
    final spaceIndex = trimmedFullName.indexOf(' ');

    final firstName = spaceIndex == -1
        ? trimmedFullName
        : trimmedFullName.substring(0, spaceIndex);

    final lastName = spaceIndex == -1
        ? ''
        : trimmedFullName.substring(spaceIndex + 1).trim();

    return RegisterRequestBody(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }
}
