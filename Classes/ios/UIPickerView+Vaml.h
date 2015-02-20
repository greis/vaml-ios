#import <UIKit/UIKit.h>

@class VamlContext;

@interface UIPickerView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
