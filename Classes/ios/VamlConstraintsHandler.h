#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VamlContext.h"

@interface VamlConstraintsHandler : NSObject

+(void)addConstraintsTo:(UIView *)view context:(VamlContext *)context;

@end
