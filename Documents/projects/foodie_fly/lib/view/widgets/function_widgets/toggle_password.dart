import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/utils/constants.dart';

Widget togglePassword() {
    return BlocBuilder<TogglepasswordCubit, bool>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<TogglepasswordCubit>().togglePassword();
          },
          icon: state
              ? const Icon(
                  Icons.visibility,
                  color:grey,
                )
              : const Icon(
                  Icons.visibility_off,
                  color: grey,
                ),
        );
      },
    );
  }