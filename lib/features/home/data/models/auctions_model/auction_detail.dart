class AuctionDetail {
  String? title;
  String? description;

  AuctionDetail({this.title, this.description});

  factory AuctionDetail.fromJson(Map<String, dynamic> json) => AuctionDetail(
        title: json['title'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
      };
}
