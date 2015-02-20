#import "UIImageView+Vaml.h"

@implementation UIImageView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  NSString *imageName = data[@"attrs"][@"name"];
  return [self initWithImage:[UIImage imageNamed:imageName]];
}

@end
