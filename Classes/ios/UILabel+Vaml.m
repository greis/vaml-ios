#import "UILabel+Vaml.h"
#import "VamlData.h"

@implementation UILabel (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setText:data[@"text"]];
  return self;
}

@end
