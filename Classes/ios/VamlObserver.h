#import <UIKit/UIKit.h>

@class VamlContext;

@interface VamlObserver : NSObject

-(id)initWithView:(UIView *)view key:(NSString *)key;
-(NSString *)key;

@end
