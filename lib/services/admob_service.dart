import 'package:firebase_admob/firebase_admob.dart';

class AdMobService {
  static InterstitialAd _interstitialAd;
  String getAdMobAppId() {
    return "ca-app-pub-9658728883249380~8077339954";
  }

  String getInterstitialAdId() {
    return "ca-app-pub-9658728883249380/1511931606";
  }

  InterstitialAd getInterstitialAd() {
    return InterstitialAd(
      adUnitId: getInterstitialAdId(),
      listener: (MobileAdEvent event) {
        print(event);
      },
    );
  }

  void showIntertitialAd() {
    if (_interstitialAd == null) _interstitialAd = getInterstitialAd();
    _interstitialAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
