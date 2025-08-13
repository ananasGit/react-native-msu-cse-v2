#import "MsuCseV2.h"

// Always try to import Swift header - will be available when built properly
#import "MsuCseV2-Swift.h"

@implementation MsuCseV2 {
    CSEBridge *_cseBridge;
}

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    if (self) {
        _cseBridge = [[CSEBridge alloc] init];
    }
    return self;
}

// MARK: - Initialization

- (void)initialize:(BOOL)developmentMode {
    [_cseBridge initializeWithDevelopmentMode:developmentMode];
}

// MARK: - Validation Methods

- (BOOL)isValidCVV:(NSString *)cvv {
    return [_cseBridge isValidCVV:cvv];
}

- (BOOL)isValidCVVWithPan:(NSString *)cvv pan:(NSString *)pan {
    return [_cseBridge isValidCVVWithPanWithCvv:cvv pan:pan];
}

- (BOOL)isValidCardHolderName:(NSString *)name {
    return [_cseBridge isValidCardHolderName:name];
}

- (BOOL)isValidPan:(NSString *)pan {
    return [_cseBridge isValidPan:pan];
}

- (BOOL)isValidCardToken:(NSString *)token {
    return [_cseBridge isValidCardToken:token];
}

- (BOOL)isValidExpiry:(double)month year:(double)year {
    return [_cseBridge isValidExpiryWithMonth:(int)month year:(int)year];
}

// MARK: - Card Brand Detection

- (NSString *)detectBrand:(NSString *)pan {
    return [_cseBridge detectBrand:pan];
}

// MARK: - Encryption Methods (Async)

- (void)encryptCvv:(NSString *)cvv
             nonce:(NSString *)nonce
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject {
    
    [_cseBridge encryptCvvWithCvv:cvv nonce:nonce callback:^(NSString * _Nullable encrypted, NSString * _Nullable error) {
        if (error) {
            reject(@"ENCRYPTION_ERROR", error, nil);
        } else {
            resolve(encrypted);
        }
    }];
}

- (void)encryptCard:(NSString *)pan
    cardHolderName:(NSString *)cardHolderName
        expiryYear:(double)expiryYear
       expiryMonth:(double)expiryMonth
               cvv:(NSString *)cvv
             nonce:(NSString *)nonce
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject {
    
    [_cseBridge encryptCardWithPan:pan
                   cardHolderName:cardHolderName
                       expiryYear:(int)expiryYear
                      expiryMonth:(int)expiryMonth
                              cvv:cvv
                            nonce:nonce
                         callback:^(NSString * _Nullable encrypted, NSString * _Nullable error) {
        if (error) {
            reject(@"ENCRYPTION_ERROR", error, nil);
        } else {
            resolve(encrypted);
        }
    }];
}

// MARK: - Error Handling

- (NSArray<NSString *> *)getErrors {
    return [_cseBridge getErrors];
}

- (BOOL)hasErrors {
    return [_cseBridge hasErrors];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeMsuCseV2SpecJSI>(params);
}
#endif

@end
