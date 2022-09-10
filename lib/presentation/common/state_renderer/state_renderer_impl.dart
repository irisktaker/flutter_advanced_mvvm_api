
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//! Loading State (PopUp or Full Screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState({required this.stateRendererType, this.message = StringManager.loading});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}