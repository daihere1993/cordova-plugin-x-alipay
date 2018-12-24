#import <Cordova/CDV.h>
#import <AlipaySDK/AlipaySDK.h>

@interface CDVXAlipay:CDVPlugin

@property (nonatomic, strong) NSString *currentCallbackId;
@property (nonatomic, strong) NSString *appid;
@property (nonatomic, strong) NSString *eventCallbackID;
@property (class, nonatomic) CDVXAlipay *sharedInstance;


- (void)initPlugin:(CDVInvokedUrlCommand *)command;
- (void)aliPayment:(CDVInvokedUrlCommand *)command;
- (BOOL)invokeDefaultCallbackWithMessage:(CDVPluginResult *)result;
+ (CDVXAlipay *)sharedManager;

@end