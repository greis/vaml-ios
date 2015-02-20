#import "UIButton+Vaml.h"

@implementation UIButton (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  self = [self init];
  [self setTitle:data[@"attrs"][@"title"] forState:UIControlStateNormal];
  return self;
}

@end
