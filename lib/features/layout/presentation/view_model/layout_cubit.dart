import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(const LayoutState());
  int currentIndex = 0;

  void changeCurrentIndex(int currentIndex) {
    this.currentIndex = currentIndex;
    emit(state.copyWith(currentIndex: currentIndex));
  }
}
