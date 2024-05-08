import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/address.dart';

class AddressApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  
  //----------------------------- Add Address -----------------------------//
  Future<bool> addAddress(Address address) async {
    try {
      final token = await getToken();
      final response = await dio.post(
        ApiEndPoints.addNewAddress,
        data: address.toJson(address),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      log('🎉${e.toString()}');
      return false;
    }
  }
  
  //----------------------------- Update Address --------------------------//
  Future<bool> updateAddress(Address address) async {
    try {
      final token = await getToken();
      final response = await dio.put(
        '${ApiEndPoints.updateAddress}${address.addressId}',
        data: address.toJson(address),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
        if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  
  //----------------------- Fetch All Addresses ----------------------------//
  Future<List<Address>> fetchAllAddresses() async {
    try {
      final token = await getToken();
      final response = await dio.get(
        ApiEndPoints.getAllAddresses,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final body = response.data as Map<String, dynamic>;
        final result = body['addressList'] as List<dynamic>;
        return result.map((json) => Address.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('👀 ${e.toString()}');
      return [];
    }
  }
  
  //------------------------- Get Address By Id ---------------------------//
  Future<Address?> getAddressById(int addressId) async {
    try {
      final token = await getToken();
      final response = await dio.get(
        '${ApiEndPoints.getAddressById}$addressId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        final body = response.data as Map<String, dynamic>;
        final result = body['address'];
        return Address.fromJson(result);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
