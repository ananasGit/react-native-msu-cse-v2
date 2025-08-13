#import "MsuCseV2.h"

// Import Swift header only when available
#if __has_include("MsuCseV2-Swift.h")
#import "MsuCseV2-Swift.h"
#define SWIFT_BRIDGE_AVAILABLE 1
#else
#define SWIFT_BRIDGE_AVAILABLE 0
#endif

@implementation MsuCseV2 {
#if SWIFT_BRIDGE_AVAILABLE
    CSEBridge *_cseBridge;
#endif
}

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    if (self) {
#if SWIFT_BRIDGE_AVAILABLE
        _cseBridge = [[CSEBridge alloc] init];
#endif
    }
    return self;
}

// MARK: - Initialization

- (void)initialize:(BOOL)developmentMode {
#if SWIFT_BRIDGE_AVAILABLE
    [_cseBridge initializeWithDevelopmentMode:developmentMode];
#endif
}

// MARK: - Validation Methods

- (BOOL)isValidCVV:(NSString *)cvv {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidCVV:cvv];
#else
    return NO;
#endif
}

- (BOOL)isValidCVVWithPan:(NSString *)cvv pan:(NSString *)pan {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidCVVWithPanWithCvv:cvv pan:pan];
#else
    return NO;
#endif
}

- (BOOL)isValidCardHolderName:(NSString *)name {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidCardHolderName:name];
#else
    return NO;
#endif
}

- (BOOL)isValidPan:(NSString *)pan {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidPan:pan];
#else
    return NO;
#endif
}

- (BOOL)isValidCardToken:(NSString *)token {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidCardToken:token];
#else
    return NO;
#endif
}

- (BOOL)isValidExpiry:(double)month year:(double)year {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge isValidExpiryWithMonth:(int)month year:(int)year];
#else
    return NO;
#endif
}

// MARK: - Card Brand Detection

- (NSString *)detectBrand:(NSString *)pan {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge detectBrand:pan];
#else
    return @"";
#endif
}

// MARK: - Encryption Methods (Async)

- (void)encryptCvv:(NSString *)cvv
             nonce:(NSString *)nonce
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject {
    
#if SWIFT_BRIDGE_AVAILABLE
    [_cseBridge encryptCvvWithCvv:cvv nonce:nonce callback:^(NSString * _Nullable encrypted, NSString * _Nullable error) {
        if (error) {
            reject(@"ENCRYPTION_ERROR", error, nil);
        } else {
            resolve(encrypted);
        }
    }];
#else
    reject(@"SWIFT_BRIDGE_UNAVAILABLE", @"Swift bridge not available", nil);
#endif
}

- (void)encryptCard:(NSString *)pan
    cardHolderName:(NSString *)cardHolderName
        expiryYear:(double)expiryYear
       expiryMonth:(double)expiryMonth
               cvv:(NSString *)cvv
             nonce:(NSString *)nonce
           resolve:(RCTPromiseResolveBlock)resolve
            reject:(RCTPromiseRejectBlock)reject {
    
#if SWIFT_BRIDGE_AVAILABLE
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
#else
    reject(@"SWIFT_BRIDGE_UNAVAILABLE", @"Swift bridge not available", nil);
#endif
}

// MARK: - Error Handling

- (NSArray<NSString *> *)getErrors {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge getErrors];
#else
    return @[];
#endif
}

- (BOOL)hasErrors {
#if SWIFT_BRIDGE_AVAILABLE
    return [_cseBridge hasErrors];
#else
    return NO;
#endif
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeMsuCseV2SpecJSI>(params);
}
#endif

@end
