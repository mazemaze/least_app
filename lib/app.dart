import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:least_app/database/firestore_helper.dart';
import 'package:least_app/entity/post.dart';
import 'package:least_app/entity/user.dart';
import 'package:least_app/screens/edit_profile_page.dart';
import 'package:least_app/screens/edit_profile_view_model.dart';
import 'package:least_app/screens/home_page.dart';
import 'package:least_app/screens/home_view_model.dart';
import 'package:least_app/screens/login_page.dart';
import 'package:least_app/screens/login_view_model.dart';
import 'package:least_app/screens/post_item_page.dart';
import 'package:least_app/screens/post_view_model.dart';
import 'package:least_app/screens/settings_page.dart';
import 'package:least_app/screens/user_detail_page.dart';
import 'package:provider/provider.dart';

class LeastApp extends StatelessWidget {
  const LeastApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<PostViewModel>(
          create: (_) => PostViewModel(),
        ),
        ChangeNotifierProvider<EditProfileViewModel>(
          create: (_) => EditProfileViewModel(),
        ),
        StreamProvider<List<PostItem>>(
          create: (_) => FirestoreHelper().fetchPosts(),
          initialData: [],
        ),
        StreamProvider<List<UserModel>>(
          create: (_) => FirestoreHelper().fetchUsers(),
          initialData: [],
        ),
      ],
      child: MaterialApp(
        routes: {
          HomePage.routeName: (_) => HomePage(),
          UserDetailPage.routeName: (_) => UserDetailPage(),
          SettingsPage.routeName: (_) => SettingsPage(),
          LoginPage.routeName: (_) => LoginPage(),
          PostItemPage.routeName: (_) => PostItemPage(),
          EditProfilePage.routeName: (_) => EditProfilePage(),
        },
        home: dependOnAuthState(),
      ),
    );
  }

  Widget dependOnAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          final vm = Provider.of<HomeViewModel>(context);
          if (vm.isLoading)
            return Scaffold(
              body: LinearProgressIndicator(),
            );
          if (vm.userModel!.isFirstLogin == true) {
            return EditProfilePage();
          }
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
