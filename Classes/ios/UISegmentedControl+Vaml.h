#import <UIKit/UIKit.h>

@class VamlContext;

@interface UISegmentedControl (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
