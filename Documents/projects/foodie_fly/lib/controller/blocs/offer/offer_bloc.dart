import 'package:bloc/bloc.dart';
import 'package:foodie_fly/controller/api_sevices/offers/api_calling.dart';
import 'package:foodie_fly/model/offer.dart';


part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitial()) {
    on<OfferEvent>((event, emit)async {
      final offers = await OfferApiServices().getAllOffer();
      emit(OfferState(offers: offers));
    });
  }
}
