#import "UIImageView+Vaml.h"
#import "VamlData.h"

@implementation UIImageView (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  NSString *imageName = data[@"name"];
  return [self initWithImage:[UIImage imageNamed:imageName]];
}

@end
