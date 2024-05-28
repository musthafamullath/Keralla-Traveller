part of 'sales_report_bloc.dart';

class SalesReportState {
  final SalesReport? report;
  SalesReportState({required this.report});
}



final class SalesReportInitial extends SalesReportState {
  SalesReportInitial() : super(report: null);
}


class SalesReportLoading extends SalesReportState {
  SalesReportLoading() : super(report: null);
}

class SalesReportLoaded extends SalesReportState {
  SalesReportLoaded(SalesReport report) : super(report: report);
}

class SalesReportError extends SalesReportState {
  final String message;
  SalesReportError({required this.message}) : super(report: null);
}