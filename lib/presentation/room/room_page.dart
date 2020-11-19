import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypsygramm/navigation_service.dart';
import 'package:gypsygramm/presentation/widgets/inputs.dart';

import '../../config/device_config.dart';
import '../../domain/entities/message/message.dart';
import '../../styles.dart';
import '../authentification/cubit/authentification_cubit.dart';
import 'cubit/room_cubit.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  RoomCubit _roomCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: primaryColorLight,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: GestureDetector(
                onTap: () => NavigationService.navigator.pop(),
                child: Icon(
                  Icons.chevron_left,
                  color: primaryColorLight,
                  size: 30,
                ),
              ),
            ),
            title: BlocBuilder<AuthentificationCubit, AuthentificationState>(
              builder: (context, state) {
                return Text(
                  state.isOnline
                      ? BlocProvider.of<RoomCubit>(context).roomName
                      : 'Waiting for network...',
                  style: title2.apply(color: primaryColorLight),
                );
              },
            ),
          ),
          body: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
            Widget messagesLayout = Expanded(flex: 1, child: Container());
            if (state is RoomInitial)
              BlocProvider.of<RoomCubit>(context).loadMessages();
            else if (state is RoomLoading)
              messagesLayout = Expanded(
                flex: 1,
                child: Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                )),
              );
            else if (state is RoomLoaded)
              messagesLayout = _buildMessagesList(state);
            return Column(
              children: [
                messagesLayout,
                BlocBuilder<AuthentificationCubit, AuthentificationState>(
                  builder: (context, state) {
                    return MessageInput(
                        BlocProvider.of<RoomCubit>(context).sendMessage,
                        state.isOnline);
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Expanded _buildMessagesList(RoomState state) {
    return Expanded(
      flex: 1,
      child: BlocListener<AuthentificationCubit, AuthentificationState>(
        listenWhen: (previous, current) =>
            (!previous.isOnline && current.isOnline),
        listener: (context, state) {
          BlocProvider.of<RoomCubit>(context).loadMessages();
        },
        child: StreamBuilder<List<Message>>(
            stream: (state as RoomLoaded).dataStream,
            initialData: (state as RoomLoaded).initialData,
            builder: (context, snapshot) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth / 30),
                child: ListView.separated(
                  reverse: true,
                  itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: SizeConfig.screenHeight / 40,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final item =
                        snapshot.data[snapshot.data.length - index - 1];
                    final created = '${DateTime.parse(item.created).hour}:' +
                        '${DateTime.parse(item.created).minute}';
                    return ListTile(
                      title: Text(
                        item.sender.username,
                        style: title3.apply(color: primaryColorDark),
                      ),
                      subtitle: Text(
                        item.text,
                        style: bodyText1,
                      ),
                      trailing: Text(
                        created,
                        style: bodyText1.apply(color: primaryColor),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final roomCubit = BlocProvider.of<RoomCubit>(context);
    setState(() {
      _roomCubit = roomCubit;
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _roomCubit.dispose();
    super.dispose();
  }
}
