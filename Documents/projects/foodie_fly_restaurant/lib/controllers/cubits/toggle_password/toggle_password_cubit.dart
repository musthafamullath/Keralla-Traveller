import 'package:bloc/bloc.dart';
part  'toggle_password_state.dart';

class TogglepasswordCubit extends Cubit<bool> {
  TogglepasswordCubit() : super(true);

  void togglePassword() {
    emit(!state);
  }
}
