import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AuctionsParams extends Equatable {
  String status;
  String? type;
  String? search;

  AuctionsParams({
    required this.status,
    required this.search,
    required this.type,
  });

  @override
  List<Object?> get props => [
        status,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      if (type != null && type!.isNotEmpty) 'type': type,
      if (search != null && search!.isNotEmpty) 'search': search,
    };
  }
}

class UserAuctionsParams extends Equatable {
  bool winner;
  bool loss;

  UserAuctionsParams({this.loss = false, this.winner = false});

  @override
  List<Object?> get props => [
        loss,
        winner,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (winner == true) 'winner': winner,
      if (loss == true) 'loss': loss,
    };
  }
}
