import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'slider_cubit_state.dart';

class SliderCubitCubit extends Cubit<int> {
  SliderCubitCubit() : super(0);

  void changePage(int page) => emit(page);
}
