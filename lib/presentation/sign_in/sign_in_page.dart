import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets.dart';
import '../../config/device_config.dart';
import '../../styles.dart';
import '../authentification/cubit/authentification_cubit.dart';
import '../widgets/buttons.dart';
import '../widgets/inputs.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _controller = TextEditingController();
  var buttonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isEmpty && buttonEnabled)
        setState(() {
          buttonEnabled = false;
        });
      else if (_controller.text.isNotEmpty && !buttonEnabled)
        setState(() {
          buttonEnabled = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColorLight,
      body: Container(
        padding: EdgeInsets.only(
          bottom: SizeConfig.screenHeight / 10,
          top: SizeConfig.screenHeight / 20,
          left: SizeConfig.screenHeight / 20,
          right: SizeConfig.screenHeight / 20,
        ),
        child: Column(
          children: [
            buildLogo(),
            Spacer(
              flex: 1,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your username',
                  style: bodyText1,
                )),
            SizedBox(
              height: SizeConfig.screenHeight / 40,
            ),
            DefaultInput(
              controller: _controller,
              hint: 'Username',
              onSubmitted: (input) {
                if (input.isNotEmpty)
                  BlocProvider.of<AuthentificationCubit>(context)
                      .signIn(username: input);
              },
              maxLength: BlocProvider.of<AuthentificationCubit>(context)
                  .settings
                  .maxUsernameLength,
            ),
            BlocBuilder<AuthentificationCubit, AuthentificationState>(
              builder: (context, state) {
                String message;
                if (state is AuthentificationNotLoggedIn)
                  message = state.message;
                return Padding(
                  padding: EdgeInsets.all(SizeConfig.screenHeight / 20),
                  child: Text(
                    message ?? '',
                    style: bodyText1.apply(color: errorColor),
                  ),
                );
              },
            ),
            Spacer(
              flex: 2,
            ),
            defaultButton(
              text: 'SIGN IN',
              press: () => BlocProvider.of<AuthentificationCubit>(context)
                  .signIn(username: _controller.text),
              color: primaryColorDark,
              enabled: buttonEnabled,
            ),
          ],
        ),
      ),
    );
  }

  buildLogo() => Image.asset(
        Assets.logo,
        height: SizeConfig.screenHeight / 10,
      );
}
