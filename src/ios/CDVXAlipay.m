#import "CDVXAlipay.h"

@implementation CDVXAlipay

#pragma mark "API"

- (void)aliPayment:(CDVInvokedUrlCommand *)command {
    self.currentCallbackId = command.callbackId;
    NSDictionary *params = [command.arguments objectAtIndex:0];
    NSString *orderString = [params objectForKey:@"order"];
    NSString *appScheme = [@"ali" stringByAppendingString:[[self.commandDelegate settings] objectForKey:@"aliappid"]];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        CDVPluginResult *pluginResult;
        
        if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.currentCallbackId];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:resultDic];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.currentCallbackId];
        }
        
    }];
}

#pragma mark "CDVPlugin Overrides"

- (void)handleOpenURL:(NSNotification *)notification {
    NSURL *url =[notification object];
    NSString *schemeStr;
    schemeStr = [@"ali" stringByAppendingString:[[self.commandDelegate settings] objectForKey:@"aliappid"]];

    if ([url isKindOfClass:[NSURL class]] && [url.scheme isEqualToString:schemeStr]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            CDVPluginResult *pluginResult;
            
            if ([[resultDic objectForKey:@"resultStatus"]  isEqual: @"9000"]) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
                [self.commandDelegate sendPluginResult: pluginResult callbackId: self.currentCallbackId];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:resultDic];
                [self.commandDelegate sendPluginResult: pluginResult callbackId: self.currentCallbackId];
            }
        }];
    }
}

#pragma mark "Private methods"

- (void)successWithCallbackID:(NSString *)callbackID {
    [self successWithCallbackID:callbackID withMessage:@"OK"];
}

- (void)successWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message {
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

- (void)failWithCallbackID:(NSString *)callbackID withError:(NSError *)error {
    [self failWithCallbackID:callbackID withMessage:[error localizedDescription]];
}

- (void)failWithCallbackID:(NSString *)callbackID withMessage:(NSString *)message {
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:message];
    [self.commandDelegate sendPluginResult:commandResult callbackId:callbackID];
}

@end
