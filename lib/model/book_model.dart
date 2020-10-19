class BookModel {
  int id;
  int prices;
  String title;
  String author;
  String description;
  String photo;
  String publisher;

  BookModel(
      {this.id,
      this.title,
      this.description,
      this.prices,
      this.author,
      this.photo,
      this.publisher});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        author: json['author'],
        publisher: json['publisher'],
        prices: json['price'],
        photo: json['photo']);
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
  };
}
