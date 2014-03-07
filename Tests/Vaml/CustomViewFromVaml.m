#import "CustomViewFromVaml.h"
#import <vaml/Vaml.h>

@implementation CustomViewFromVaml

- (id)init {
  self = [super init];
  if (self) {
    [self applyVamlLayout:@"custom-view"];
  }
  return self;
}

@end
