
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_repasswod/toggle_repassword_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';

Widget toggleRePassword() {
    return BlocBuilder<ToggleRepasswordCubit, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<ToggleRepasswordCubit>().toggleRepassword();
          },
          icon: state
              ? const Icon(
                  Icons.visibility,
                  color: grey,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: grey,
                ),
        );
      },
    );
  }