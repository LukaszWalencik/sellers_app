// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sellers_app/model/menus_model.dart';
import 'package:sellers_app/screens/global/global.dart';
import 'package:sellers_app/screens/items_upload_screen.dart';
import 'package:sellers_app/screens/menus_upload_screen.dart';
import 'package:sellers_app/widgets/custom_drawer.dart';
import 'package:sellers_app/widgets/text_header.dart';

class ItemsScreen extends StatefulWidget {
  final MenusModel? menusModel;
  const ItemsScreen({
    Key? key,
    this.menusModel,
  }) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.green,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          sharedPreferences!.getString('sellerName')!,
          style: const TextStyle(fontSize: 30, fontFamily: 'Lobster'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemsUploadScreen(
                              menusModel: widget.menusModel,
                            )));
              },
              icon: const Icon(Icons.library_add))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextHeader(title: 'My ${widget.menusModel!.menuTitle}'),
          ),
        ],
      ),
    );
  }
}