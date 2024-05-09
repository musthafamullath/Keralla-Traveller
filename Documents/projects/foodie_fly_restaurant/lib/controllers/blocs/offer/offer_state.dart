part of 'offer_bloc.dart';

class OfferState {
  final List<Offer> offers;
  OfferState({required this.offers});
}

final class OfferInitial extends OfferState {
  OfferInitial() : super(offers: []);
}



//addoffer
final class AddOfferSuccessState extends OfferState {
  AddOfferSuccessState({required super.offers});
}

final class AddOfferInvalidInputs extends OfferState {
  AddOfferInvalidInputs({required super.offers});
}

final class AddOfferFailedToGetImageFromForm extends OfferState {
  AddOfferFailedToGetImageFromForm({required super.offers});
}

final class AddOfferFailedToParseBody extends OfferState {
  AddOfferFailedToParseBody({required super.offers});
}

final class AddOfferFailedToOpenFilePathInServer extends OfferState {
  AddOfferFailedToOpenFilePathInServer({required super.offers});
}

final class AddOfferFailedToUploadFileToCloud extends OfferState {
  AddOfferFailedToUploadFileToCloud({required super.offers});
}

final class AddOfferFailedToDeleteTempImage extends OfferState {
  AddOfferFailedToDeleteTempImage({required super.offers});
}

final class AddOfferErrorOccuredWhileCreatingOffer extends OfferState {
  AddOfferErrorOccuredWhileCreatingOffer({required super.offers});
}

final class AddOfferErrorState extends OfferState {
  AddOfferErrorState({required super.offers});
}
//edit offer
final class UpdateOfferSuccessState extends OfferState {
 

  UpdateOfferSuccessState( {required super.offers});
 
}
final class UpdateOfferErrorState extends OfferState {
  

  UpdateOfferErrorState( {required super.offers});
 
}
final class GetOfferByCategoryState extends OfferState {
 

  GetOfferByCategoryState( {required super.offers});

 
}
