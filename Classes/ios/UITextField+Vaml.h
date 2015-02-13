#import <UIKit/UIKit.h>

@class VamlContext;

@interface UITextField (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
