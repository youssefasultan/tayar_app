import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tayar_app/core/common/app/localization/app_locale.dart';
import 'package:tayar_app/core/common/widgets/popup_item.dart';
import 'package:tayar_app/core/services/injection_container.dart';
import 'package:tayar_app/core/utils/constants/view_constants.dart';
import 'package:tayar_app/src/authentication/presntation/bloc/auth_bloc.dart';
import 'package:tayar_app/src/authentication/presntation/widgets/create_password_alert_dialog.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        AppLocale.profile.getString(context),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
          color: kBlack,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => BlocProvider(
                    create: (_) => sl<AuthBloc>(),
                    child: const CreatePasswordAlertDialog(),
                  ),
                );
              },
              child: PopupItem(
                label: AppLocale.changePass.getString(context),
                icon: const Icon(
                  Icons.key,
                  color: kBlack,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () {
                context.read<AuthBloc>().add(LogoutRequestedEvent());
                unawaited(
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  ),
                );
              },
              child: PopupItem(
                label: AppLocale.logout.getString(context),
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
