class BookModel {
  final String title;
  final String author;
  final int pages;
  final String language;
  final String department;

  final String imageBase64; // تأكد من إضافة هذا الحقل

  BookModel({
    required this.title,
    required this.author,
    required this.pages,
    required this.language,
    required this.department,
    required this.imageBase64,
  });

  get imagePath => null;

  get imageUrl => null;
}
