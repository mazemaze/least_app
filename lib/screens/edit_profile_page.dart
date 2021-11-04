import 'dart:io';

import 'package:flutter/material.dart';
import 'package:least_app/screens/edit_profile_view_model.dart';
import 'package:least_app/screens/home_page.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  static const routeName = 'edit_profile';
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EditProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            },
            child: Text(
              "スキップ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async => await vm.selectImage(),
                      child: CircleAvatar(
                        foregroundImage: vm.isSet == true
                            ? Image.file(
                                File(vm.newImgUrl!.path),
                                fit: BoxFit.cover,
                              ).image
                            : NetworkImage(vm.defaultImgUrl),
                        maxRadius: 64,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("クリックして画像を選択")
                  ],
                ),
              ),
              TextField(
                onChanged: (value) => vm.getNickName(value),
                decoration: InputDecoration(
                  hintText: "ニックネーム",
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => vm.updateUser(),
                  child: Text("決定"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
