import 'dart:async';

import 'package:advanced_flutter/domain/models/models.dart';
import 'package:advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';

class OnboardingViewModel extends BaseViewModel with OnboardingViewModelInputs, OnboardingViewModelOutputs 
{  
  //! using stream controllers for Outputs
  //? to communicate view_model with the view
  //** the stream is like a PIPE
  //   streams can have multi listeners and all listeners will receive the same value when it's puts in the pipeline
  //?  we put values in the streams by using the stream controller
  //   streams are the outputs of stream_controller 
  //   !note: StreamController 
  //    1- outputs called stream >> return the logical conditions results 
  //    2- inputs called sink >> sink contains all ui events - stream inputs //*/

  //? compare inputs(ui events) with the outputs(stream - the code logic) then return the result
  // --------------------------------------------------------------------------------------------------------- 

  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;


  //! Onboarding View Model Inputs ------------
  @override
  void dispose() {
    _streamController.close();
  }

  @override 
  void start() { // view model start job
    // ! ex: call user api's
    _list = _getSliderData();
    _postDataToView();
  }

  // ------------------
  
  @override
  int goNext() {  
    int nextIndex = ++_currentIndex;
    if(nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }
  
  @override
  int goPrevious() {
    int prevuesIndex = --_currentIndex; // do action first
    if(prevuesIndex==0) {
      prevuesIndex = _list.length-1;
    }
    return prevuesIndex;  
  }
  
  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }
  
  @override
  Sink get inputSliderViewObject => _streamController.sink;
  

  //! Onboarding View Model Outputs ------------
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((event) => event);


  //? onboarding private function

  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
    SliderObject(StringManager.onBoardingTitle1, StringManager.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
    SliderObject(StringManager.onBoardingTitle2, StringManager.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
    SliderObject(StringManager.onBoardingTitle3, StringManager.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
    SliderObject(StringManager.onBoardingTitle4, StringManager.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
  ];
} 


// ? Inputs means "the orders" that the view_model will receive from view
abstract class OnboardingViewModelInputs 
{
  int goNext();
  int goPrevious();
  void onPageChanged(int index); //! avoid using setState()

  //? stream controller input => sink
  Sink get inputSliderViewObject;

}

abstract class OnboardingViewModelOutputs  //! using stream controllers
{
  //? stream controller output => stream
  Stream<SliderViewObject> get outputSliderViewObject;
}

