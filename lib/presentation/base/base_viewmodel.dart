abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs
  { //! shared variables and functions that will be used in any view model
    
  }

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // end(kill) view model job
}

abstract class BaseViewModelOutputs {}