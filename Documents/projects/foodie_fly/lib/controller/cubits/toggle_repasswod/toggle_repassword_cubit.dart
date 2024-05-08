import 'package:bloc/bloc.dart';
part 'toggle_repassword_state.dart';

class ToggleRepasswordCubit extends Cubit<bool> {
  ToggleRepasswordCubit() : super(true);
  
  void toggleRepassword(){
    emit(!state);
  }
}
