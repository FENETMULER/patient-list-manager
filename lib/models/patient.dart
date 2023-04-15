class Patient {
  final String firstName;
  final String lastName;
  final int age;
  final String sex;
  final String phoneNumber;
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
      this.houseNumber,
      this.district,
      this.subCity,
      this.diagnosis,
      this.id});
}
