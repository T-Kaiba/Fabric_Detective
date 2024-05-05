import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../common/top_card.dart';
import 'signup_screen_viewmodel.dart';

class SignupScreenView extends StackedView<SignupScreenViewModel> {
  const SignupScreenView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SignupScreenViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [topCard(false)],
      ),
    );
  }

  @override
  SignupScreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SignupScreenViewModel();
}
