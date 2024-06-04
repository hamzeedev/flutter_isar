import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_setting.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteTile({super.key, required this.text, this.onEditPressed, this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        title: Text(text),
        trailing: Builder(
          builder: (context)=> IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: ()=> showPopover(
            width: 100,
            height: 100,
            backgroundColor: Theme.of(context).colorScheme.surface,
            context: context, 
            bodyBuilder: (context) =>  NoteSetting(
              onEditTap: onEditPressed,
              onDeleteTap: onDeletePressed,
            )
            ),
        )
          ),
      ),
    );
  }
}