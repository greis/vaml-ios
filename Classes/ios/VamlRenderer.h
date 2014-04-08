#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VamlContext.h"

@interface VamlRenderer : NSObject

-(id)initWithView:(UIView *)view vaml:(NSString *)vaml context:(VamlContext *)context;

-(void)render;

@end
