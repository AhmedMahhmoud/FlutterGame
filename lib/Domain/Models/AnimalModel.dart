class Animal {
  final int id;
  final String categoryName;
  final String categoryImage;
  final List<String> itemsName;

  Animal({
    this.id,
    this.categoryName,
    this.categoryImage,
    this.itemsName,
  });
  Map<String, dynamic> toMap() {
    return {
      'catName': this.categoryName,
      'catImage': this.categoryImage,
      "id": this.id,
      "itemsNames": this.itemsName
    };
  }

  factory Animal.fromMap(int id, Map<String, dynamic> map) {
    return Animal(
        id: id,
        categoryImage: map["catImage"] ?? "cat image",
        categoryName: map["catName"],
        itemsName: map["itemsNames"].cast<String>());
  }
}
