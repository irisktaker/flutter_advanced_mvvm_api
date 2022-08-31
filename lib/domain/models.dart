

// **************************************************************************
// ! onboarding models
// **************************************************************************

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

// **************************************************************************
// ! login models
// **************************************************************************

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer customer;
  Contacts contacts;
  Authentication(this.customer, this.contacts);
}