import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdHelper {
  /// 플랫폼에 따른 배너 광고 단위 ID 반환
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // 실제 안드로이드 광고 단위 ID로 교체
      return 'ca-app-pub-6067483456795008/8522658706';
    } else if (Platform.isIOS) {
      // 실제 iOS 광고 단위 ID로 교체
      return 'ca-app-pub-6067483456795008/5269212934';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// 배너 광고 생성 및 로드
  static BannerAd createBannerAd() {
    BannerAd bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('배너 광고 로드 성공'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('배너 광고 로드 실패: $error');
        },
      ),
    );
    // 광고 로드 시작
    bannerAd.load();
    return bannerAd;
  }

  /// 앱 초기화 시 Google Mobile Ads SDK 초기화
  static Future<InitializationStatus> initializeAds() {
    return MobileAds.instance.initialize();
  }
}
