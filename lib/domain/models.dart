
// ! onboarding models
class SliderObject {
  String title, subtitle, image;
  SliderObject(this.title, this.subtitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSliders;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numberOfSliders, this.currentIndex);
}