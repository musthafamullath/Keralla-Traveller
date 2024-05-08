// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:foodie_fly/controller/api_end_points/end_points.dart';
import 'package:foodie_fly/controller/api_tokens/tokens.dart';
import 'package:foodie_fly/model/profile.dart';

class ProfileApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));

  Future<Profile?> getUserProfile() async {
    
    try {
      final token = await getToken();
      final response = await dio.get(
        ApiEndPoints.getUserProfile,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        final body = response.data as Map;
        final result = body['user'] as Map<String, dynamic>;
        final Profile user = Profile.fromJson(result);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> updateUser(Profile profile) async {
    final token = await getToken();
    final data = {
      'email': profile.email,
      'firstName': profile.firstName,
      'lastName': profile.lastName
    };
    try {
      final response = await dio.patch(
        ApiEndPoints.updateUserProfile,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
