#import "CustomViewFromVaml.h"
#import <vaml/Vaml.h>

@implementation CustomViewFromVaml

- (id)init {
  self = [super init];
  if (self) {
    [self applyVamlLayout:@"custom-view"];
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    [self.layer setBorderWidth:1.0];
  }
  return self;
}

@end
