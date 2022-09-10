import 'dart:async';

import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs
  { //! shared variables and functions that will be used in any view model
    // FlowState general and we will use it in multi screens so we use it in the base view model not in each screen 
    final StreamController _inputStreamController = StreamController<FlowState>.broadcast();//broadcast = multi listener
    // ?note: StreamController needs two mean things (sink(inputs), stream(outputs))
    
    @override
    Sink get inputState => _inputStreamController.sink;

    @override 
    Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);

    // when the current view model die we need to dispose the StreamController
    @override
    void dispose() {
      _inputStreamController.close();
    }
  }

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // end(kill) view model job

  // sink(inputs)
  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  
  // stream(outputs)
  Stream<FlowState> get outputState;
}