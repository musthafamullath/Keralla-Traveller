part of 'offer_bloc.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferLoaded extends OfferState {
  final List<Offer> offers;

  OfferLoaded({required this.offers});
}

class OfferError extends OfferState {
  final String message;

  OfferError({required this.message});
}

class OfferUpdateLoading extends OfferState {}

class OfferUpdateSuccess extends OfferState {
  final List<Offer> offers;
  OfferUpdateSuccess({required this.offers});
}

class OfferUpdateError extends OfferState {
  final String message;
  OfferUpdateError({required this.message});
}
