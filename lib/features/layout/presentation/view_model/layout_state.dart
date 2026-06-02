// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'layout_cubit.dart';

class LayoutState extends Equatable {
  const LayoutState({
    this.currentIndex = 0,
  });
  final int currentIndex;

  @override
  List<Object> get props => [
        currentIndex,
      ];

  LayoutState copyWith({
    int? currentIndex,
  }) {
    return LayoutState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
