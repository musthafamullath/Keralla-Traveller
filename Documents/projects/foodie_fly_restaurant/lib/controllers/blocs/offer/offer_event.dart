part of 'offer_bloc.dart';

class OfferEvent {}

class GetOffersEvent extends OfferEvent {

}

class AddCategoryEvent extends OfferEvent {
  int categoryId;
  AddCategoryEvent({required this.categoryId});
}


class AddOfferEvent extends OfferEvent {
  final OfferRequest offerRequest;
  AddOfferEvent({required this.offerRequest});
}


class UpdateOfferEvet extends OfferEvent{
   final Offer offer;

  UpdateOfferEvet( {required this.offer,});
}


class GetOfferByCategoryEvent extends OfferEvent {

  final int categoryIds;

  GetOfferByCategoryEvent({required this.categoryIds});
 
}