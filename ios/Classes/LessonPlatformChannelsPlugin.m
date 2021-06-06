#import "LessonPlatformChannelsPlugin.h"
#if __has_include(<lesson_platform_channels/lesson_platform_channels-Swift.h>)
#import <lesson_platform_channels/lesson_platform_channels-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lesson_platform_channels-Swift.h"
#endif

#import "pigeon.h"

@interface MyMultiplyApi : NSObject <MultiplyApi>
@end

@implementation MyMultiplyApi
-(MultiplyResult*)multiply:(MultiplyRequest*)request error:(FlutterError **)error {
  MultiplyResult *result = [[MultiplyResult alloc] init];
  int multiplicand = [request.multiplicand intValue];
  int multiplier = [request.multiplier intValue];
  int multiplicationResult = multiplicand * multiplier;
  result.result = [NSNumber numberWithInt:multiplicationResult];

  return result;
}
@end

@implementation LessonPlatformChannelsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLessonPlatformChannelsPlugin registerWithRegistrar:registrar];

  MyMultiplyApi *api = [[MyMultiplyApi alloc] init];

  MultiplyApiSetup(registrar.messenger, api);
}
@end
