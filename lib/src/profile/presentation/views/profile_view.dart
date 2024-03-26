import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/profile/presentation/bloc/report_bloc.dart';
import 'package:tayar_app/src/profile/presentation/widgets/delivery_chart.dart';
import 'package:tayar_app/src/profile/presentation/widgets/profile_app_bar.dart';
import 'package:tayar_app/src/profile/presentation/widgets/user_info_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack.withOpacity(0.8),
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const UserInfoView(),
          BlocProvider(
            create: (context) => sl<ReportBloc>(),
            child: const DeliveryChart(),
          ),
        ],
      ),
    );
  }
}
