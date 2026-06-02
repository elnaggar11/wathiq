class Pagination {
  int? currentPage;
  int? resultCount;
  int? totalPages;

  Pagination({this.currentPage, this.resultCount, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json['currentPage'] as int?,
        resultCount: json['resultCount'] as int?,
        totalPages: json['totalPages'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'resultCount': resultCount,
        'totalPages': totalPages,
      };
}
