import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../product/circular_progress/circular_progress_indicator.dart';
import '../add_helper_view.dart';

class AddBannerView extends StatefulWidget {
  const AddBannerView({Key? key}) : super(key: key);

  @override
  State<AddBannerView> createState() => _AddBannerViewState();
}

class _AddBannerViewState extends State<AddBannerView> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AddHelperView.bannerAddUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isBannerAdReady
        ? Container(
            child: AdWidget(ad: _bannerAd),
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            alignment: Alignment.center,
          )
        : CallCircularProgress(context);
  }

  @override
  void dispose() {
    _bannerAd.dispose();

    super.dispose();
  }
}
