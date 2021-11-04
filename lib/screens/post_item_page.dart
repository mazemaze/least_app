import 'package:flutter/material.dart';
import 'package:least_app/screens/post_view_model.dart';
import 'package:provider/provider.dart';

class PostItemPage extends StatelessWidget {
  const PostItemPage({Key? key}) : super(key: key);

  static const routeName = 'post_item';
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PostViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close),
                  ),
                  IconButton(
                    onPressed: () => vm.registerNewPostItem(context),
                    icon: Icon(Icons.post_add_outlined),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: TextField(
                      onChanged: (value) => vm.getContent(value),
                      maxLines: 10,
                      maxLength: 80,
                      decoration:
                          InputDecoration(hintText: "今日の気分、明日何をしたいか、何をしたか。"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
