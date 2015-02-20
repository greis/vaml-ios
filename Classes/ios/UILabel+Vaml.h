#import <UIKit/UIKit.h>

@class VamlContext;

@interface UILabel (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
