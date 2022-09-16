// ignore_for_file: constant_identifier_names

import 'package:advanced_flutter/presentation/resources/all_resources.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {

  //? POPUP STATE (DIALOG)
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //? FULL SCREEN STATE (FULL SCREEN)
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  FULL_SCREEN_EMPTY_STATE,

  //? GENERAL
  CONTENT_STATE,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer({required this.stateRendererType, this.message = StringManager.loading, this.title = "", required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getReturnWidget(context);
  }

  Widget _getReturnWidget(BuildContext context){
    switch (stateRendererType) {
        
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context, [_getAnimatedJsonImage(JsonAssets.loading)]);

      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context, [
          _getAnimatedJsonImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(StringManager.ok, context),
        ]);
      
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsColumn([_getAnimatedJsonImage(JsonAssets.loading), _getMessage(message)]);

      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsColumn([
          _getAnimatedJsonImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(StringManager.retryAgain, context),
        ]);

      case StateRendererType.FULL_SCREEN_EMPTY_STATE:
        return _getItemsColumn([
          _getAnimatedJsonImage(JsonAssets.empty),
          _getMessage(message),
        ]);

      case StateRendererType.CONTENT_STATE:
        return Container();
      
      default:
        return Container();

    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),  
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedJsonImage(String animationName) {
     return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

   Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(message,style: getRegularStyle(ColorManager.black, FontSize.f18)),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
     return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              if (stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE) {
                // call retry function
                retryActionFunction.call();

              } else {
                // popup error state
                Navigator.of(context).pop();
              }
            },
            child: Text(buttonTitle))),
      ),
    );
  }

}