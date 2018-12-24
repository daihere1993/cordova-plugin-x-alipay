//
//  AppDelegate+XAlipay.h
//  cordova-plugin-x-alipay
//
//  Created by DerekChia on 2018/12/20.
//

#ifndef AppDelegate_XAlipay_h
#define AppDelegate_XAlipay_h


#endif /* AppDelegate_XAlipay_h */

#import "AppDelegate.h"

@interface AppDelegate (XAlipay)

@property (nonatomic) BOOL xalipayIsReplaceMethod;

- (BOOL)XAlipayApplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end
