/**
 * SplashScreen
 * 启动屏
 * from：http://www.devio.org
 * Author:CrazyCodeBoy
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

#import "RNSplashScreen.h"
#import <React/RCTBridge.h>

static UIView* loadingView = nil;

@implementation RNSplashScreen
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE(SplashScreen)

+ (void)show {
    if (!loadingView) {
        loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil] objectAtIndex:0];
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;

        CGRect frame = currentWindow.frame;
        frame.origin = CGPointMake(0, 0);
        loadingView.frame = frame;

        [loadingView setAlpha: 0];
        [currentWindow addSubview:loadingView];
        [currentWindow bringSubviewToFront:loadingView];

        [UIView transitionWithView:loadingView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            [loadingView setAlpha:1];
        } completion:nil];
    }
}

+ (void)showSplash:(NSString*)splashScreen inRootView:(UIView*)rootView {
    NSLog(@"noop");
}

+ (void)hide {
    if (loadingView) {
        UIView* hidingLoadingView = loadingView;
        loadingView = nil;
        [UIView transitionWithView:hidingLoadingView duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void){
            [hidingLoadingView setAlpha:0];
        } completion:^(BOOL finished){
            [hidingLoadingView removeFromSuperview];
        }];
    }
}

+ (void) jsLoadError:(NSNotification*)notification
{
    // If there was an error loading javascript, hide the splash screen so it can be shown.  Otherwise the splash screen will remain forever, which is a hassle to debug.
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(hide) {
    [RNSplashScreen hide];
}

RCT_EXPORT_METHOD(show) {
    [RNSplashScreen show];
}

@end
