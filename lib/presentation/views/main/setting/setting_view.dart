import 'package:bloc_clean_architecture/core/router/app_router.dart';
import 'package:bloc_clean_architecture/presentation/blocs/settings/settings_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    context.read<SettingsBloc>().add(SettingInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingSuccessState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(imageUrl: state.user.avatar!),
                Text('${state.user.name} - ${state.user.email}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<SettingsBloc>().add(SettingLogoutEvent());
                  },
                  child: const Text(
                    'Logout',
                  ),
                ),
              ],
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is SettingToLogout) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRouter.signin, (route) => false);
          }
        },
      ),
    );
  }
}
