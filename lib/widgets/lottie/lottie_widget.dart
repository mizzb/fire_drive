import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final String? lottieType;
  final double? lottieWidth;
  final int? lottieDuration;

  const LottieWidget({this.lottieType, this.lottieWidth, this.lottieDuration});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (lottieWidth != null)
          ? lottieWidth
          : MediaQuery.of(context).size.width * 0.3,
      child: loadLottie(lottieType, context),
    );
  }

  loadLottie(lottieType, context) {
    switch (lottieType) {
      case 'loading':
        return fetchLottie(context, 'assets/lottie/loading.json');
      case 'uploading':
        return fetchLottie(context, 'assets/lottie/loading.json');
      case 'fetching':
        return fetchLottie(context, 'assets/lottie/loading_stones.json');
      default:
        return fetchLottie(context, 'assets/lottie/loading.json');
    }
  }

  LottieBuilder fetchLottie(context, path) {
    return Lottie.asset(
      path,
      key: UniqueKey(),
      frameBuilder: (context, child, composition) {
        return AnimatedOpacity(
          child: child,
          opacity: 1,
          duration: Duration(
              seconds: (lottieDuration != null) ? lottieDuration! : 120),
        );
      },
    );
  }
}
