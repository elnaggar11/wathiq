class CompanyPhoneNumber {
  String? key;
  String? number;

  CompanyPhoneNumber({this.key, this.number});

  factory CompanyPhoneNumber.fromJson(Map<String, dynamic> json) {
    return CompanyPhoneNumber(
      key: json['key'] as String?,
      number: json['number'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'number': number,
      };
}
