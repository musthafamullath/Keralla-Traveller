import 'package:dio/dio.dart';
import 'package:foodie_fly_restaurant/controllers/api_end_points/api_end_points.dart';
import 'package:foodie_fly_restaurant/controllers/api_tokens/tokens.dart';
import 'package:foodie_fly_restaurant/models/sales.report.dart';

class SalesApiServices {
  Dio dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));

  Future<SalesReport?> getSalesReport() async {
    try {
      final token = await getToken();
      final response = await dio.get(
        ApiEndPoints.dailyStatus,
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
        final result = body['result'] as Map<String, dynamic>;
        final salesReport = SalesReport.fromJson(result);
        return salesReport;
      } else {
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
