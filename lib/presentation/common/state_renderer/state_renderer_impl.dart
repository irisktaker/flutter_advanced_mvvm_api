
import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//? Loading State (PopUp or Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState(this.stateRendererType, [this.message = StringManager.loading]);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

}

//! Error State (PopUp or Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);

  @override 
  String getMessage() => message;

  @override 
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content State 
class ContentState extends FlowState {
  ContentState();

  @override 
  String getMessage() => Constants.empty;

  @override 
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;
}

//! Empty State (Full Screen)
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);

  @override 
  String getMessage() => message;

  @override 
  StateRendererType getStateRendererType() => StateRendererType.FULL_SCREEN_EMPTY_STATE;
}