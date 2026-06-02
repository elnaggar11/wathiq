class InvoiceModel {
  final String message;
  final Pagination pagination;
  final List<Invoice> data;

  InvoiceModel({
    required this.message,
    required this.pagination,
    required this.data,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      message: json['message'],
      pagination: Pagination.fromJson(json['pagination']),
      data: List<Invoice>.from(json['data'].map((x) => Invoice.fromJson(x))),
    );
  }
}

class Pagination {
  final int currentPage;
  final int resultCount;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.resultCount,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      resultCount: json['resultCount'],
      totalPages: json['totalPages'],
    );
  }
}

class Invoice {
  final String id;
  final String userId;
  final String invoiceNo;
  final String? billNo;
  final bool isClientEnterpise;
  final String nationalId;
  final String internalCode;
  final DateTime issueDate;
  final DateTime dueDate;
  final int totalAmount;
  final List<Product> products;
  final bool exportToSadad;
  final String status;
  final int balanceAfterPayment;

  Invoice({
    required this.id,
    required this.userId,
    required this.invoiceNo,
    this.billNo,
    required this.isClientEnterpise,
    required this.nationalId,
    required this.internalCode,
    required this.issueDate,
    required this.dueDate,
    required this.totalAmount,
    required this.products,
    required this.exportToSadad,
    required this.status,
    required this.balanceAfterPayment,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['_id'],
      userId: json['userId'],
      invoiceNo: json['invoiceNo'],
      billNo: json['billNo'],
      isClientEnterpise: json['IsClientEnterpise'],
      nationalId: json['NationalId'],
      internalCode: json['InternalCode'],
      issueDate: DateTime.parse(json['IssueDate']),
      dueDate: DateTime.parse(json['DueDate']),
      totalAmount: json['TotalAmount'],
      products:
          List<Product>.from(json['Products'].map((x) => Product.fromJson(x))),
      exportToSadad: json['ExportToSadad'],
      status: json['status'],
      balanceAfterPayment: json['balanceAfterPayment'],
    );
  }
}

class Product {
  final String productCode;
  final int price;
  final String id;

  Product({
    required this.productCode,
    required this.price,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productCode: json['ProductCode'],
      price: json['Price'],
      id: json['_id'],
    );
  }
}
