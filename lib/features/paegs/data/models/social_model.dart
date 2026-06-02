class SocialModel {
  final String? message;
  final ContactData? data;

  SocialModel({this.message, this.data});

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      message: json['message'] as String?,
      data: json['data'] != null ? ContactData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ContactData {
  final PhoneNumber? phoneNumber;
  final Address? address;
  final PhoneNumber? whatsapp;
  final String? id;
  final String? email;
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final String? linkedin;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final List<Office>? ourOffice;

  ContactData({
    this.phoneNumber,
    this.address,
    this.whatsapp,
    this.id,
    this.email,
    this.instagram,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.ourOffice,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      phoneNumber: json['phoneNumber'] != null
          ? PhoneNumber.fromJson(json['phoneNumber'])
          : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      whatsapp: json['whatsapp'] != null
          ? PhoneNumber.fromJson(json['whatsapp'])
          : null,
      id: json['_id'] as String?,
      email: json['email'] as String?,
      instagram: json['instagram'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      linkedin: json['linkedin'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      ourOffice: (json['ourOffice'] as List<dynamic>?)
          ?.map((e) => Office.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber?.toJson(),
      'address': address?.toJson(),
      'whatsapp': whatsapp?.toJson(),
      '_id': id,
      'email': email,
      'instagram': instagram,
      'facebook': facebook,
      'twitter': twitter,
      'linkedin': linkedin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'ourOffice': ourOffice?.map((e) => e.toJson()).toList(),
    };
  }
}

class PhoneNumber {
  final String? number;
  final String? key;

  PhoneNumber({this.number, this.key});

  factory PhoneNumber.fromJson(Map<String, dynamic> json) {
    return PhoneNumber(
      number: json['number'] as String?,
      key: json['key'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'key': key,
    };
  }
}

class Address {
  final double? latitude;
  final double? longitude;
  final String? title;

  Address({this.latitude, this.longitude, this.title});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'title': title,
    };
  }
}

class Office {
  final String? name;
  final String? link;
  final String? id;

  Office({this.name, this.link, this.id});

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      name: json['name'] as String?,
      link: json['link'] as String?,
      id: json['_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'link': link,
      '_id': id,
    };
  }
}
