#import "UIPickerView+Vaml.h"
#import "VamlContext.h"

@implementation UIPickerView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  self = [self init];
  [self setDelegate:context.target];
  [self setDataSource:context.target];
  return self;
}

@end
