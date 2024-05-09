import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import '../../../models/profile.dart';

class ProfileApiServices {
  final Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));
  Future<Profile?> getSellerProfile() async {
    try {
      final token = await getToken();
      final response = await dio.get(
        ApiEndPoints.getSellerProfile,
        options: Options(
          headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        ),
        
      );

      if (response.statusCode == 200) {
        final body = response.data as Map;

        final result = body['result'];
        final profile = Profile.fromJson(result);

        await saveSellerId(profile.sellerId);
        return profile;
      }
    } catch (e) {
      
      log("🎉${e.toString()}");
    }
    return null;
  }
}
