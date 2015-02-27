#import "UIButton+Vaml.h"
#import "VamlData.h"

@implementation UIButton (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setTitle:data[@"title"] forState:UIControlStateNormal];
  return self;
}

@end
