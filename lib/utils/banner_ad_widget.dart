import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:slow_food/utils/add_helper.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: GoogleAdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
          print('배너 광고 로드 성공');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          setState(() {
            _isAdLoaded = false;
          });
          print('배너 광고 로드 실패: $error');
        },
      ),
    );
    _bannerAd!.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 광고가 로드되지 않았을 경우에도 고정된 높이의 컨테이너를 반환하여 레이아웃에 빈 공간을 차지하게 함
    if (!_isAdLoaded || _bannerAd == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 50, // 고정 높이 또는 예상 광고 높이로 설정
        alignment: Alignment.center,
        child: Text(
          '광고 로드 실패',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    // 화면의 가로 크기를 가져와 광고의 width와 비교
    final screenWidth = MediaQuery.of(context).size.width;
    final adWidth = _bannerAd!.size.width.toDouble();
    final containerWidth = screenWidth < adWidth ? screenWidth : adWidth;
    final containerHeight = _bannerAd!.size.height.toDouble();

    return Container(
      alignment: Alignment.topCenter,
      width: containerWidth,
      height: containerHeight,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
