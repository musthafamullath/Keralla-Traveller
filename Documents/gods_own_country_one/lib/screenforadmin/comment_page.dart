import 'dart:io';
import 'package:flutter/material.dart';
import 'package:keralatraveller/db_functions/user_db_fucntion.dart';
import 'package:keralatraveller/modal/addtohomeadmin.dart';
import 'package:keralatraveller/modal/commentdb.dart';
import 'package:keralatraveller/modal/mycountry.dart';
import 'package:keralatraveller/refacteredclasses/app_toolbarsearch.dart';
import 'package:keralatraveller/refacteredclasses/leanir.dart';
import 'package:keralatraveller/refactoredwidgets/app_colors.dart';
import 'package:keralatraveller/refactoredwidgets/app_strings.dart';
import 'package:keralatraveller/refactoredwidgets/app_textstyles.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class CommendScreen extends StatefulWidget {
  final AddToHomeAdmin addToHomeAdmin;
  const CommendScreen({Key? key, required this.addToHomeAdmin}) : super(key: key);

  @override
  State<CommendScreen> createState() => _CommendScreenState();
}

class _CommendScreenState extends State<CommendScreen> {
  int? userindex;
  late Box commentBox;
  late Box mycountryBox;
  List<Comment> filteredComments = [];

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    commentBox = Hive.box('comment');
    mycountryBox = Hive.box("mycountry");
    getUserIndex();
    filterCommentsByMovieKey();
    super.initState();
  }

  Future<void> getUserIndex() async {
    userindex = await isfavor();
    setState(() {});
  }

  void filterCommentsByMovieKey() {
    List allComments = commentBox.values.toList();
    filteredComments = List<Comment>.from(allComments
        .where((element) => element.commentindex == widget.addToHomeAdmin.key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppToolBar(title: AppStrings.comments),
      body: BackgroundWrapper(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: AppColor.buttoncolor,
                  height: 1,
                  thickness: 1,
                ),
                itemCount: filteredComments.length,
                itemBuilder: (context, index) {
                  Comment comment = filteredComments[index];
                  Mycountry? mycountry =
                      mycountryBox.get(comment.userid) as Mycountry?;
                  if (mycountry != null) {
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColor.buttoncolor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 1, color: AppColor.black),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: mycountry.imageUser != null
                              ? Image.file(
                                  File(mycountry.imageUser.toString()),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 30.0,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      title: Text(
                        mycountry.name,
                        style: Apptext.text8,
                      ),
                      subtitle: Text(comment.comment, style: Apptext.text2),
                      trailing: Text(
                        '${DateFormat('dd-MMM-yyyy').format(comment.date)}\n\n${comment.formattedTime}',
                        style: Apptext.text2,
                      ),
                    );
                  } else {
                    return const ListTile(
                      title: Text('User not found'),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: AppStrings.addacomment,
                        fillColor: Color.fromARGB(255, 214, 197, 197),
                        filled: true,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (userindex != null && commentController.text.isNotEmpty) {
                        Hive.box('comment').add(Comment(
                          commentindex: widget.addToHomeAdmin.key,
                          userid: userindex!,
                          comment: commentController.text,
                          date: DateTime.now(),
                        ));
                        setState(() {
                          commentController.clear();
                          filterCommentsByMovieKey();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
