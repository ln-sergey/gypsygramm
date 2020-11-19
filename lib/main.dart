import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes.dart';
import 'data/local/local_storage_controller.dart';
import 'domain/repositories/room_repository.dart';
import 'domain/repositories/rooms_repository.dart';
import 'injection.dart';
import 'navigation_service.dart';
import 'presentation/authentification/cubit/authentification_cubit.dart';
import 'presentation/room/cubit/room_cubit.dart';
import 'presentation/room/room_page.dart';
import 'presentation/rooms/cubit/rooms_cubit.dart';
import 'presentation/rooms/rooms_page.dart';
import 'presentation/sign_in/sign_in_page.dart';
import 'presentation/splash/splash_page.dart';
import 'styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await getIt<LocalStorageController>().init();
  runApp(
    BlocProvider(
      create: (context) => getIt<AuthentificationCubit>(),
      child: MultiRepositoryProvider(providers: [
        RepositoryProvider<RoomsRepository>(
          create: (context) => getIt<RoomsRepository>(),
        ),
        RepositoryProvider<RoomRepository>(
          create: (context) => getIt<RoomRepository>(),
        ),
      ], child: App()),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthentificationCubit, AuthentificationState>(
      listenWhen: (previous, current) {
        if (previous.runtimeType == current.runtimeType &&
            previous.isOnline != current.isOnline)
          return false;
        else
          return true;
      },
      listener: (context, state) {
        if (state is AuthentificationNotLoggedIn && state.message == null)
          NavigationService.navigator.pushReplacementNamed(AppRoutes.signIn);
        else if (state is AuthentificationLoggedIn)
          NavigationService.navigator.pushReplacementNamed(AppRoutes.rooms);
      },
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        onGenerateRoute: (settings) {
          if (settings.name == AppRoutes.signIn)
            return MaterialPageRoute(
                builder: (_) => SafeArea(child: SignInPage()));
          else if (settings.name == AppRoutes.rooms)
            return MaterialPageRoute(builder: (_) => _buildRooms());
          else if (settings.name == AppRoutes.history)
            return MaterialPageRoute(
                builder: (_) => _buildRoom(settings.arguments));
          else
            return MaterialPageRoute(
                builder: (_) => SafeArea(child: SplashPage()));
        },
        initialRoute: AppRoutes.splash,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          canvasColor: Colors.transparent,
        ),
      ),
    );
  }

  BlocProvider<RoomCubit> _buildRoom(String roomName) {
    return BlocProvider<RoomCubit>(
      create: (context) => RoomCubit(
          BlocProvider.of<AuthentificationCubit>(context),
          RepositoryProvider.of<RoomRepository>(context),
          roomName),
      child: SafeArea(child: RoomPage()),
    );
  }

  BlocProvider<RoomsCubit> _buildRooms() {
    return BlocProvider<RoomsCubit>(
      create: (context) => RoomsCubit(
          BlocProvider.of<AuthentificationCubit>(context),
          RepositoryProvider.of<RoomsRepository>(context))
        ..loadRooms(),
      child: SafeArea(child: RoomsPage()),
    );
  }
}
