#import <UIKit/UIKit.h>

@class VamlContext;

@interface UIImageView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
