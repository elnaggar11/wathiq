import 'package:equatable/equatable.dart';

class GetQuestionsParams extends Equatable {
  String? search;
  String? categoryId;
  GetQuestionsParams({
    this.search,
    this.categoryId,
  });

  @override
  List<Object?> get props => [
        search,
        categoryId,
      ];
}
