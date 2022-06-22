import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/model/base_view_model.dart';
import '../../../core/init/service/cacheManager/CacheManager.dart';
import '../view/onboard_lottie_view.dart';
import '../../product/contstants/image_path.dart';

import '../../authentication/onboard/view/onboard_view.dart';
part 'onboard_initial_view_model.g.dart';

class OnBoardInitialViewModel = _OnBoardInitialViewModelBase with _$OnBoardInitialViewModel;

abstract class _OnBoardInitialViewModelBase with Store, BaseViewModel {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @observable
  String? _initialApkMoode;

  @observable
  bool isInitialModelLoading = false;

  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    getUserRole();
  }

  Widget directDashboard() {
    return _initialApkMoode == "0" ? OnBoardLottieView() : OnBoardView();
  }

  @action
  Future<void> getUserRole() async {
    changeIsInitialModeLoading();

    _initialApkMoode = CacheManager.instance.getInitialApk();
    if (_initialApkMoode != null) {
      if (_initialApkMoode == "0") {
        await CacheManager.instance.putInitialApk("1");
      }
    }

    await Future.delayed(Duration(seconds: 3));

    changeIsInitialModeLoading();
  }

  @action
  void changeIsInitialModeLoading() {
    isInitialModelLoading = !isInitialModelLoading;
  }
}
