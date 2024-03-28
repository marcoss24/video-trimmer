#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(VideoTrimmer, NSObject)
    RCT_EXTERN_METHOD(trimVideo:(NSString *)sourceURL startTime:(double)startTime endTime:(double)endTime callback:(RCTResponseSenderBlock)callback)
@end
