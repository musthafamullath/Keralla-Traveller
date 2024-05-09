import 'package:bloc/bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/profile/api_calling.dart';
import 'package:foodie_fly_restaurant/models/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(
      (event, emit) async {
        final profile = await ProfileApiServices().getSellerProfile();
        if (profile == null) {
          final profile = Profile(
            description: 'description',
            email: 'email',
            name: 'name',
            pinCode: 'pinCode',
            sellerId: 0,
            status: 'status',
          );
          emit(ProfileState(profile: profile));
        }else{
          emit(ProfileState(profile: profile));
        }
      },
    );
  }
}
