import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../../../../core/base/view/base_view.dart';
import '../../product/circular_progress/circular_progress_indicator.dart';
import '../../product/contstants/image_path.dart';
import '../viewmodel/onboard_initial_view_model.dart';

class OnBoardInitialView extends StatelessWidget {
  OnBoardInitialView({Key? key}) : super(key: key);

  OnBoardInitialViewModel onBoardViewModel = OnBoardInitialViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardInitialViewModel>(
        viewModel: OnBoardInitialViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, OnBoardInitialViewModel viewModel) {
          return buildScaffold(context, viewModel);
        });
  }

  Observer buildScaffold(BuildContext context, OnBoardInitialViewModel viewModel) {
    return Observer(builder: (_) {
      return Scaffold(
        key: viewModel.scaffoldState,
        body: viewModel.isInitialModelLoading
            ? Center(
                child: Padding(
                  padding: context.horizontalPaddingNormal,
                  child: HeartbeatProgressIndicator(
                    child: SizedBox(
                      height: context.dynamicHeight(0.3),
                      width: context.dynamicWidth(0.7),
                      child: Lottie.asset(
                        ImagePaths.instance.loti_1,
                        repeat: true,
                        reverse: true,
                        animate: true,
                      ),
                    ),
                  ),
                ),
              )
            : viewModel.directDashboard(),
      );
    });
  }
}
