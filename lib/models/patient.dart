class Patient {
  final String firstName;
  final String lastName;
  final int age;
  final String sex;
  final String phoneNumber;
  final DateTime registeredOn;
  final String? houseNumber;
  final String? district;
  final String? subCity;
  final String? diagnosis;
  final String? id;
  Patient(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.sex,
      required this.phoneNumber,
      required this.registeredOn,
      this.houseNumber,
      this.district,
      this.subCity,
      this.diagnosis,
      this.id});

  String get getInitial {
    return firstName[0];
  }
}
