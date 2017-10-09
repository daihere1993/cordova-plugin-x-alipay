#import <Cordova/CDV.h>
#import <AlipaySDK/AlipaySDK.h>

@interface CDVXAlipay:CDVPlugin

@property (nonatomic, strong) NSString *currentCallbackId;
@property (nonatomic, strong) NSString *appid;

- (void)aliPayment:(CDVInvokedUrlCommand *)command;

@end