// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/offers/api_calling.dart';
import 'package:foodie_fly_restaurant/models/offer.dart';
import 'package:foodie_fly_restaurant/utils/constants.dart';
import 'package:foodie_fly_restaurant/views/widgets/function_widgets/snackbar_function.dart';
part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferBloc() : super(OfferInitial()) {
    on<GetAllOffersEvent>((event, emit) async {
      emit(OfferLoading());
      try {
        final offers = await OfferApiServices().getAllOffers();
        emit(OfferLoaded(offers: offers));
      } catch (e) {
        emit(OfferError(message: e.toString()));
      }
    });
    on<AddOfferEvent>((event, emit) async {
      emit(OfferLoading());
      try {
        final value = await OfferApiServices().addOffer(event.offer);
        if (value) {
          final offers = await OfferApiServices().getAllOffers();
          emit(OfferLoaded(offers: offers));
          Navigator.of(event.context).pop();
          showSnack(event.context, green, 'Offer added successfully');
        } else {
          showSnack(event.context, red, 'Offer cant add');
          emit(OfferError(message: 'Failed to add offer'));
        }
      } catch (e) {
        emit(OfferError(message: e.toString()));
      }
    });
    on<UpdateOfferEvent>((event, emit) async {
      emit(OfferUpdateLoading());
      try {
        final value = await OfferApiServices().updateOffer(event.offer);
        if (value) {
          final offers = await OfferApiServices().getAllOffers();
          emit(OfferUpdateSuccess(offers: offers));
          Navigator.of(event.context).pop();
          showSnack(event.context, green, 'Offer updated successfully');
        } else {
          showSnack(event.context, red, 'Offer can\'t be updated');
          emit(OfferUpdateError(message: 'Failed to update offer'));
        }
      } catch (e) {
        emit(OfferUpdateError(message: 'Failed to update offer'));
      }
    });
  }
}
