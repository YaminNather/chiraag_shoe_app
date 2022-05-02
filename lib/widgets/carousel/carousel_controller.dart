import 'package:flutter/material.dart';

class CarouselController extends ChangeNotifier {
  CarouselController() {
    pageController.addListener(notifyListeners);
  }  

  int getCurrentPage() {
    try {
      return pageController.page!.round();
    }
    catch(e) {
      return 0;
    }
  }

  Future<void> animateToPage(
    final int index, 
    {
      Duration duration = const Duration(milliseconds: 500),
      Curve curve = Curves.easeInOut
    }
  ) async {        
    await pageController.animateToPage(index, duration: duration, curve: curve);
  }

  @override
  void dispose() {
    pageController.removeListener(notifyListeners);

    super.dispose();
  }



  final PageController pageController = PageController();
}