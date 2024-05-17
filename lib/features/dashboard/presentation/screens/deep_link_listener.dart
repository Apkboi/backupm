import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentra/core/di/injector.dart';

import 'package:mentra/core/services/firebase/deep_link_naigator.dart';
import 'package:mentra/features/dashboard/presentation/bloc/deep_link_bloc/deep_link_bloc.dart';

class DeepLinkListener extends StatelessWidget {
  final Widget child;

  const DeepLinkListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeepLinkBloc, DeepLinkState>(
      bloc: injector.get<DeepLinkBloc>(),
      listener: (context, state) {
        if (state is ActiveDeepLink) {
          DeepLinkNavigator.handlePushNotificationClick(state.data);
        }
      },
      child: child,
    );
  }
}
