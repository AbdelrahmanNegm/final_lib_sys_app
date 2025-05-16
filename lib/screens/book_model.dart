class Book {
  final int id;
  final String name;
  final String? description;
  final String? shelf;
  final bool isAvailable;
  final String? department;
  final int assignedYear;
  final String? image;
  final List<String> categoryNames;
  final List<String> authorNames;

  Book({
    required this.id,
    required this.name,
    required this.description,
    required this.shelf,
    required this.isAvailable,
    required this.department,
    required this.assignedYear,
    required this.image,
    required this.categoryNames,
    required this.authorNames,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      shelf: json['shelf'],
      isAvailable: json['isAvailable'] ?? true,
      department: json['department'],
      assignedYear: json['assignedYear'] ?? 0,
      image: json['image'],
      categoryNames: List<String>.from(json['categoryNames'] ?? []),
      authorNames: List<String>.from(json['authorNames'] ?? []),
    );
  }
}
