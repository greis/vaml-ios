#import "UIPickerView+Vaml.h"
#import "VamlData.h"

@implementation UIPickerView (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setDelegate:data.target];
  [self setDataSource:data.target];
  return self;
}

@end
