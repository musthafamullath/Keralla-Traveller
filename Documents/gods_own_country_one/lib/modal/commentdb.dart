import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
part 'commentdb.g.dart';


@HiveType(typeId: 4)
class Comment extends HiveObject {
  @HiveField(0)
  final int userid;
  @HiveField(1)
  final String commentindex;
  @HiveField(2)
  final String comment;
  @HiveField(3)
  final DateTime date;

  Comment({
    required this.commentindex,
    required this.userid,
    required this.comment,
    required this.date,
  
  });
  String get formattedDate => DateFormat(AppStrings.dateformate).format(date);
  String get formattedTime => DateFormat(AppStrings.timeformate).format(date);


  
}
