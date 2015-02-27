#import "UITextField+Vaml.h"
#import "UIView+Vaml.h"
#import "VamlData.h"

@implementation UITextField (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setPlaceholder:data[@"placeholder"]];
  [self setText:data[@"text"]];
  return self;
}

@end
