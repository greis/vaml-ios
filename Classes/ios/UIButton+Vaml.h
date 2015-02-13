#import <UIKit/UIKit.h>

@class VamlContext;

@interface UIButton (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
