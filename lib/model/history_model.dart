
class HistoryModel {
  String transId;
  int userId;
  String date;
  String total;

  HistoryModel({this.transId, this.userId, this.date, this.total});

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
        userId: json['user_id'],
        transId: json['trans_id'],
        date: json['date'],
        total: json['total']);
  }
}

class DetailTransactionModel {
  String transId;
  int bookId;
  int id;
  String title;
  String author;
  String description;
  int prices;
  String photo;

  DetailTransactionModel(
      {this.id,
      this.transId,
      this.bookId,
      this.description,
      this.author,
      this.title,
      this.photo,
      this.prices});

  factory DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    return DetailTransactionModel(
      id: json['id'],
      transId: json['trans_id'],
      bookId: json['book_id'],
      author: json['author'],
      title: json['title'],
      description: json['description'],
      photo: json['photo'],
      prices: json['price']
    );
  }
}

class TransInfo {
  int userId;
  String transId;
  String date;
  String total;

  TransInfo({this.transId, this.userId, this.total, this.date});

  factory TransInfo.fromJson(Map<String, dynamic> json) {
    return TransInfo(
      transId: json['trans_id'],
      userId: json['user_id'],
      date: json['date'],
      total: json['total']
    );
  }
}
