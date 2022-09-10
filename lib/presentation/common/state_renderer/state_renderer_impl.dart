
import 'package:advanced_flutter/app/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:flutter/material.dart';

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

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget, Function retryActionFunction) {
  
  // means which one of the flow states is on runtime (runtimeType) now 
  // this means all the flow states
    switch (runtimeType) {
      case LoadingState: // popup or full screen
      { 
        if(getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) 
        {
          // show loading popup
          showPopUp(context, getStateRendererType(), getMessage());

          // show content behind popup
          return contentScreenWidget;

        } 
        
        else 
        {
          // full screen loading state
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      }

      case ErrorState: {
        dismissDialog(context);
        if(getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) 
        {
          // show error popup 
          showPopUp(context, getStateRendererType(), getMessage()); // getStateRendererType() == StateRendererType.POPUP_ERROR_STATE

          // show content behind popup
          return contentScreenWidget;
        } 

        else 
        {
          // full screen error state
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      }

      case ContentState: {
        dismissDialog(context);
        return contentScreenWidget;
      }

      case EmptyState: {
        return StateRenderer(
          stateRendererType: getStateRendererType(),
          message: getMessage(),
          retryActionFunction: (){}, // empty 
        );
      }
        
      default: {
        dismissDialog(context);
        return contentScreenWidget;
      }
    }
  }

  _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  dismissDialog(BuildContext context) {
    if(_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
  
  showPopUp(BuildContext context, StateRendererType stateRendererType, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
      context: context, 
      builder: (BuildContext context){
        return StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: (){},
        );
    }));
  }
} 