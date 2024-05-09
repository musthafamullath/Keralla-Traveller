import 'package:bloc/bloc.dart';
import 'package:foodie_fly_restaurant/controllers/api_services/sales_report/api_calls.dart';
import 'package:foodie_fly_restaurant/models/sales.report.dart';

part 'sales_report_event.dart';
part 'sales_report_state.dart';

class SalesReportBloc extends Bloc<SalesReportEvent, SalesReportState> {
  SalesReportBloc() : super(SalesReportInitial()) {
    on<GetDailySalesReportEvent>((event, emit) async {
      final report = await SalesApiServices().getSalesReport();
      emit(SalesReportState(report: report));
    });
  }
}
