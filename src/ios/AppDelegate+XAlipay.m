//
//  AppDelegate+XAlipay.m
//  cordova-plugin-x-alipay
//
//  Created by DerekChia on 2018/12/20.
//

#import "AppDelegate+XAlipay.h"
#import <AlipaySDK/AlipaySDK.h>
#import <objc/runtime.h>
#import "CDVXAlipay.h"

@implementation AppDelegate (XAlipay)

BOOL _xalipayIsReplaceMethod = YES;

+ (void)load
{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        
        SEL orginSel = @selector(application:openURL:options:);
        SEL overrideSel = @selector(XAlipayApplication:openURL:options:);
        
        Method originMethod = class_getInstanceMethod([self class], orginSel);
        Method overrideMethod = class_getInstanceMethod([self class], overrideSel);
        
        if (class_addMethod([self class], orginSel, method_getImplementation(overrideMethod) , method_getTypeEncoding(originMethod))) {
            class_replaceMethod([self class], overrideSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
            _xalipayIsReplaceMethod = YES;
        }else{
            method_exchangeImplementations(originMethod, overrideMethod);
            _xalipayIsReplaceMethod = NO;
        }
    });
}

- (BOOL)XAlipayApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            CDVPluginResult *pluginResult;
            NSMutableDictionary *eventResultDic = [NSMutableDictionary dictionaryWithDictionary:resultDic];
            if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                NSLog(@"alipay success");
                [eventResultDic setObject:@"XAlipay_StandbyCallback_Success" forKey:@"eventName"];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:eventResultDic];
                [[CDVXAlipay sharedManager] invokeDefaultCallbackWithMessage:pluginResult];
            } else {
                NSLog(@"alipay error");
                [eventResultDic setObject:@"XAlipay_StandbyCallback_Error" forKey:@"eventName"];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:eventResultDic];
                [[CDVXAlipay sharedManager] invokeDefaultCallbackWithMessage:pluginResult];
            }
        }];
    }
    
    if (!_xalipayIsReplaceMethod) {
        [self XAlipayApplication:app openURL:url options:options];
    }
    
    return YES;
}

@end
