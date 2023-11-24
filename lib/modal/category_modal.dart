class CategoryModal {
  int? id;
  String? title;
  String? image;

  CategoryModal(this.id, this.title, this.image);

  factory CategoryModal.fromMap({required Map Category}) {

    return CategoryModal(
      Category['Id'],
      Category['Title'],
      Category['Image'],
    );
  }
}