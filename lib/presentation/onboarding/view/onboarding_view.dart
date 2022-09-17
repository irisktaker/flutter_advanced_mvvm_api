import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/presentation/resources/all_resources.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  final OnboardingViewModel _viewModel = OnboardingViewModel();
  final AppPreferences _preferences = instance<AppPreferences>();

  _bind() {
    _preferences.setOnBoardingViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    super.initState();
    _bind();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ! we must have stream listener to listen From the stream controller in this case in onboarding_viewmodel.dart file
   
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget (SliderViewObject? sliderViewObjectEvent) {
    TextStyle? textButtonTheme = Theme.of(context).textTheme.labelMedium;

    if(sliderViewObjectEvent == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        // appBar: AppBar(
        //   systemOverlayStyle: SystemUiOverlayStyle(
        //     statusBarColor: ColorManager.white,
        //     statusBarBrightness: Brightness.dark,
        //   ),
        // ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: sliderViewObjectEvent.numberOfSliders,
          onPageChanged: (index) => _viewModel.onPageChanged(index),
          itemBuilder: (context, index) => OnBoardingPage(sliderViewObjectEvent.sliderObject),
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(alignment: Alignment.centerRight, child: TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, RoutesManager.loginRoute),
                child: Text(StringManager.skip, textAlign: TextAlign.end, style: textButtonTheme),
              )),
              _getBottomSheetWidget(sliderViewObjectEvent),
            ],
          ),
        ),
      );
    }
  }

  // ? _getBottomSheetWidget

  Widget _getBottomSheetWidget(SliderViewObject? sliderViewObjectEvent) => Container(
    color: ColorManager.primary,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () => _pageController.animateToPage(_viewModel.goPrevious(), duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), curve: Curves.bounceInOut),
            ),
          ),
  
          Row(
            children: [
              for(int i=0; i<sliderViewObjectEvent!.numberOfSliders;i++)
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: _getProperCircle(i, sliderViewObjectEvent.currentIndex),
              ), 
            ],
          ),
  
          // right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
              onTap: () => _pageController.animateToPage(_viewModel.goNext(), duration: const Duration(milliseconds: AppConstants.sliderAnimationTime), curve: Curves.bounceInOut),
            ),
          ),
      ],
    ),
  );

  // ? _getProperCircle

  Widget _getProperCircle(int index, int currentIndex) {
    if(index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? splashTitle = Theme.of(context).textTheme.titleMedium; 
    TextStyle? smallBodyText = Theme.of(context).textTheme.bodyMedium; 

    return Column(
      children: [
        const Spacer(flex: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m60),
          child: Column(
            children: [
              Text(
                _sliderObject.title,
                textAlign: TextAlign.center,
                style: splashTitle,
              ),
              const SizedBox(height: AppPadding.p16),
              Text(
                _sliderObject.subtitle,
                textAlign: TextAlign.center,
                style: smallBodyText,
              ),
            ],
          ),
        ),
        const Spacer(flex: 10),
        SvgPicture.asset(_sliderObject.image),
        const Spacer(flex: 20),
      ],
    );
  }
}