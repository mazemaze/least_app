import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:least_app/entity/post.dart';
import 'package:least_app/entity/user.dart';
import 'package:least_app/screens/home_view_model.dart';
import 'package:least_app/screens/login_page.dart';
import 'package:least_app/screens/post_item_page.dart';
import 'package:least_app/screens/settings_page.dart';
import 'package:least_app/screens/user_detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "home";

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    List<PostItem> posts = Provider.of<List<PostItem>>(context);
    List<UserModel> users = Provider.of<List<UserModel>>(context);

    if (vm.isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () =>
              Navigator.of(context).pushNamed(PostItemPage.routeName)),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(vm.userModel!.imgUrl!),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Container(
                height: 32,
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              child: Icon(Icons.logout, color: Colors.white),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (ctx, i) {
                  final user = users.map((e) {
                    if (e.userName == posts[i].user) {
                      return e;
                    }
                  });
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(UserDetailPage.routeName),
                            child: CircleAvatar(
                              maxRadius: 24,
                              foregroundImage:
                                  NetworkImage(user.first!.imgUrl!),
                            ),
                          ),
                        ],
                      ),
                      title: Container(
                        padding: EdgeInsets.only(top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  posts[i].user!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                SizedBox(width: 8),
                                Text(posts[i].getFormattedDate(),
                                    style: Theme.of(context).textTheme.caption),
                                GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () => vm.deletePost(posts[i].docId!),
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              posts[i].content!,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Icon(Icons.comment_outlined, size: 20),
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        vm.addLike(posts[i].docId!, posts[i]);
                                      },
                                      child: Icon(
                                          vm.userModel!.likes!
                                                  .contains(posts[i].docId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 20),
                                    ),
                                    if (posts[i].likes! > 0)
                                      Text(
                                        posts[i].likes.toString(),
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
