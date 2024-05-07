// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sellers_app/model/menus_model.dart';
import 'package:sellers_app/screens/items_screen.dart';

class InfoDesign extends StatefulWidget {
  MenusModel? menusModel;
  BuildContext? context;
  InfoDesign({
    Key? key,
    this.menusModel,
    this.context,
  }) : super(key: key);

  @override
  State<InfoDesign> createState() => _InfoDesignState();
}

class _InfoDesignState extends State<InfoDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemsScreen(
              menusModel: widget.menusModel,
            ),
          ),
        );
      },
      splashColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
          height: 285,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              Image.network(
                widget.menusModel!.thumbnailUrl!,
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1),
              Text(
                widget.menusModel!.menuTitle!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontFamily: 'Train',
                ),
              ),
              Text(
                widget.menusModel!.menuInfo!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
              ),
              const Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
