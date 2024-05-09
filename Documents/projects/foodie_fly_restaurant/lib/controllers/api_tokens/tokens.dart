import 'package:shared_preferences/shared_preferences.dart';

saveToken(String token)async{
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('token', token);
}

Future<String> getToken() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? bearer = preferences.getString('token');
  return bearer!;
}

saveSellerId(int sellerId)async{
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setInt("sellerId", sellerId);
}
getSellerId()async{
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final sellerId = preferences.getInt("sellerId" );
  return sellerId;
}
