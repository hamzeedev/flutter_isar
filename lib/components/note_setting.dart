import 'package:flutter/material.dart';

class NoteSetting extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const NoteSetting({super.key, this.onEditTap, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        // edit
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onEditTap!(); 
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child: Center(
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold
                ),
                )),
          ),
        ),
        // delete
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
            onDeleteTap!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.surface,
            child:  Center(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold
                ),
              )
              ),
          ),
        ),
      ],
    );
  }
}