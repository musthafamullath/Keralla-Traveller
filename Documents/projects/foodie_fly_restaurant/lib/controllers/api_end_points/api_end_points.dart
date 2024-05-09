class ApiEndPoints {
  static const String baseUrl = 'http://10.0.2.2:8989';
  // static const String baseUrl = 'https://l6t4rpf1-8989.inc1.devtunnels.ms';
  static const String sellerRegister = '/seller/register';
  static const String sellerLogin = '/seller/login';
  static const String getSellerProfile = '/seller/profile';
  static const String addDish = '/seller/addDish';
  static const String dailyStatus = '/seller/sales?filter=daily';
  static const String totelStatus = '/seller/sales';
  static const String categories = '/categories';
  static const String getDishesByCategory = '/seller/dishes?category=';
  static const String deleteOrUpdateDish = '/seller/dishes/';
  static const String addOffers = '/seller/offers/addOffer';
  static const String getAllOffers = '/seller/offers';
  static const String getAllOrders = '/seller/orders';
  static const String getOrderById = '/seller/orders/';
}
