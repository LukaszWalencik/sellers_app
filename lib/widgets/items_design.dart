// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sellers_app/model/items_model.dart';

class ItemsDesign extends StatefulWidget {
  ItemsModel? itemModel;
  BuildContext? context;
  ItemsDesign({
    Key? key,
    this.itemModel,
    this.context,
  }) : super(key: key);

  @override
  State<ItemsDesign> createState() => _ItemsDesignState();
}

class _ItemsDesignState extends State<ItemsDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ItemsScreen(
        //       menusModel: widget.menusModel,
        //     ),
        //   ),
        // );
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
              Text(
                widget.itemModel!.itemTitle!,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontFamily: 'Train',
                ),
              ),
              Image.network(
                widget.itemModel!.thumbnailUrl!,
                height: 220,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 1),
              Text(
                widget.itemModel!.itemInfo!,
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
