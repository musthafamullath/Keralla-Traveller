part of 'offer_bloc.dart';

abstract class OfferEvent {}

class GetAllOffersEvent extends OfferEvent {}

class AddOfferEvent extends OfferEvent {
  final OfferRequest offer;
  final BuildContext context;
  AddOfferEvent({required this.offer, required this.context});
}

class UpdateOfferEvent extends OfferEvent {
  final Offer offer;
  final BuildContext context;

  UpdateOfferEvent({required this.offer, required this.context});
}
