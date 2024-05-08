// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodie_fly/controller/api_sevices/address/api_calling.dart';
import 'package:foodie_fly/model/address.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddAddressEvent>(addAddressEvent);
    on<UpdateAddressEvent>(updateAddressEvent);
    on<GetAllAddressEvent>(getAllAddressEvent);
    on<SelectAddressEvent>(selectAddressEvent);
  }
  FutureOr<void> addAddressEvent(
      AddAddressEvent event, Emitter<AddressState> emit)async {
        final value = await AddressApiServices().addAddress(event.address);
        if(value){
          final addresses = await AddressApiServices().fetchAllAddresses();
          emit(AddressState(addresses: addresses));
        }else{
        
        }
      }

  FutureOr<void> updateAddressEvent(
      UpdateAddressEvent event, Emitter<AddressState> emit) async {
        final value = await AddressApiServices().updateAddress(event.address);
        if(value){
          final addresses = await AddressApiServices().fetchAllAddresses();
          emit(AddressState(addresses: addresses));
        }else{

        }
      }

  FutureOr<void> getAllAddressEvent(
      GetAllAddressEvent event, Emitter<AddressState> emit) async {
        final adresses = await AddressApiServices().fetchAllAddresses();
        emit(AddressState(addresses: adresses));
      }

  FutureOr<void> selectAddressEvent(
      SelectAddressEvent event, Emitter<AddressState> emit) async {
        final addresses = await AddressApiServices().fetchAllAddresses();
        emit(AddressState(addresses: addresses,index: event.index));
      }
}
