class OrderStatus {
  final String orderStatus;

  OrderStatus({required this.orderStatus});
  Map<String, dynamic> toJson(OrderStatus status) {
    final Map<String, dynamic> data = {
      'orderStatus': status.orderStatus,
    };
    return data;
  }
}