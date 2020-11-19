import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypsygramm/config/device_config.dart';
import 'package:gypsygramm/presentation/authentification/cubit/authentification_cubit.dart';
import 'package:gypsygramm/styles.dart';

import '../../assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    BlocProvider.of<AuthentificationCubit>(context).init();
    return Container(
      child: Scaffold(
        backgroundColor: primaryColorLight,
        body: Center(
          child: Image.asset(Assets.logo),
        ),
      ),
    );
  }
}
