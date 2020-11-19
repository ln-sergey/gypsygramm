import 'package:flutter/material.dart';

import '../../styles.dart';

class CreateRoomFloatingActionButton extends StatefulWidget {
  Widget Function() _bottomSheet;

  CreateRoomFloatingActionButton(this._bottomSheet) : super();

  @override
  _CreateRoomFloatingActionButtonState createState() =>
      _CreateRoomFloatingActionButtonState(_bottomSheet);
}

class _CreateRoomFloatingActionButtonState extends State<CreateRoomFloatingActionButton> {
  bool showFab = true;
  Widget Function() _bottomSheet;

  _CreateRoomFloatingActionButtonState(this._bottomSheet) : super();

  @override
  Widget build(BuildContext context) {
    return showFab
        ? FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              var bottomSheetController = showBottomSheet(
                  context: context, builder: (context) => _bottomSheet());
              showFoatingActionButton(false);
              bottomSheetController.closed.then((value) {
                showFoatingActionButton(true);
              });
            },
          )
        : Container();
  }

  void showFoatingActionButton(bool value) {
    setState(() {
      showFab = value;
    });
  }
}
