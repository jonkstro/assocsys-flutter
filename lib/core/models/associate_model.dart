class AssociateModel {
  final String id;
  final String name;
  final String registrationNumber;
  final String birthDate;
  final String email;
  final String imageUrl;
  final String registrationDate;
  bool isActive;

  AssociateModel({
    required this.id,
    required this.name,
    required this.registrationNumber,
    required this.birthDate,
    required this.email,
    required this.imageUrl,
    required this.registrationDate,
    required this.isActive,
  });
}
