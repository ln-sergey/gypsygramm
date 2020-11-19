import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/device_config.dart';
import '../../config/routes.dart';
import '../../domain/entities/room/room.dart';
import '../../navigation_service.dart';
import '../../styles.dart';
import '../authentification/cubit/authentification_cubit.dart';
import '../widgets/buttons.dart';
import '../widgets/floatting_button.dart';
import '../widgets/inputs.dart';
import 'cubit/rooms_cubit.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        resizeToAvoidBottomInset: true,
        backgroundColor: primaryColorLight,
        appBar: AppBar(
          title: BlocBuilder<AuthentificationCubit, AuthentificationState>(
            builder: (context, state) {
              return Text(
                state.isOnline ? 'GypsyGramm' : 'Waiting for network...',
                style: title2.apply(color: primaryColorLight),
              );
            },
          ),
        ),
        floatingActionButton: CreateRoomFloatingActionButton(() =>
            _buildRoomBottomSheet((roomName) => Navigator.of(context)
                .pushNamed(AppRoutes.history, arguments: roomName))),
        drawer: _buildDrawer(context),
        body: BlocBuilder<RoomsCubit, RoomsState>(builder: (context, state) {
          if (state is RoomsInitial) {
            BlocProvider.of<RoomsCubit>(context).loadRooms();
            return Container();
          } else if (state is RoomsLoading)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ));
          return BlocListener<AuthentificationCubit, AuthentificationState>(
            listenWhen: (previous, current) =>
                (!previous.isOnline && current.isOnline),
            listener: (context, state) {
              BlocProvider.of<RoomsCubit>(context).loadRooms();
            },
            child: StreamBuilder(
              stream: (state as RoomsLoaded).dataStream,
              initialData: (state as RoomsLoaded).initialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final listRooms = snapshot.data as List<Room>;
                return roomsListView(listRooms);
              },
            ),
          );
        }));
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: primaryColorLight,
        child: ListView(children: [
          DrawerHeader(
            child: Text(
              (BlocProvider.of<AuthentificationCubit>(context).state
                      as AuthentificationLoggedIn)
                  .username,
              style: title1.apply(color: primaryColorLight),
            ),
            decoration: BoxDecoration(
              color: primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(SizeConfig.screenWidth / 20),
            child: defaultButton(
              text: 'SIGN OUT',
              color: primaryColorDark,
              press: () =>
                  BlocProvider.of<AuthentificationCubit>(context).signOut(),
            ),
          ),
        ]),
      ),
    );
  }

  Container _buildRoomBottomSheet(Function(String) onCreate) {
    var controller = TextEditingController();
    return Container(
      margin: EdgeInsets.only(
          right: SizeConfig.screenWidth / 10,
          left: SizeConfig.screenWidth / 10,
          bottom: SizeConfig.screenHeight / 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black12, spreadRadius: 5)
        ],
        color: primaryColorLight,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenWidth / 20,
          horizontal: SizeConfig.screenWidth / 10),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            'Create new chatting room',
            style: title3,
          ),
          SizedBox(
            height: SizeConfig.screenHeight / 10,
          ),
          DefaultInput(
            controller: controller,
            hint: 'Room name',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9().,;?]'))
            ],
          ),
          SizedBox(
            height: SizeConfig.screenHeight / 9,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => NavigationService.navigator.pop(),
                  child: Text(
                    'cancel',
                    style: title3.apply(color: primaryColor),
                  )),
              SizedBox(
                width: SizeConfig.screenWidth / 20,
              ),
              GestureDetector(
                  onTap: () {
                    if (controller.text.isNotEmpty) {
                      NavigationService.navigator.pop();
                      onCreate(controller.text);
                    }
                  },
                  child: Text(
                    'create',
                    style: title3.apply(color: primaryColor),
                  )),
            ],
          )
        ],
      ),
    );
  }

  ListView roomsListView(List<Room> listRooms) {
    return ListView.separated(
      itemCount: listRooms.length,
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth / 20),
          child: Divider(
            color: primaryColorDark,
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final item = listRooms[index];
        final name = item.name;
        final username = item.lastMessage.sender.username;
        final message = item.lastMessage;
        final created =
            '${DateTime.parse(listRooms[index].lastMessage.created).hour}:' +
                '${DateTime.parse(listRooms[index].lastMessage.created).minute}';
        String avatarLetters;
        try {
          avatarLetters = '${name[0].toUpperCase()}${name[1].toUpperCase()}';
        } on RangeError {
          avatarLetters = '${name[0].toUpperCase()}';
        }
        return ListTile(
          onTap: () async {
            return Navigator.of(context)
                .pushNamed(AppRoutes.history, arguments: listRooms[index].name);
          },
          leading: Container(
            padding: EdgeInsets.all(SizeConfig.screenWidth / 30),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: primaryColor),
            child: Text(
              avatarLetters,
              style: title3.apply(color: primaryColorLight),
            ),
          ),
          title: Text(
            name,
            style: title3.apply(color: primaryColorDark),
          ),
          subtitle: Text(
            '$username: ${message.text}',
            style: bodyText1,
            maxLines: 2,
          ),
          trailing: Text(
            created,
            style: title4.apply(color: primaryColor),
          ),
          contentPadding: EdgeInsets.all(SizeConfig.screenWidth / 40),
        );
      },
    );
  }
}
