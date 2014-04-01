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

-(void)didLoadFromVaml {
  UILabel *message1 = (UILabel *)[self findViewById:@"message1"];
  UILabel *message2 = (UILabel *)[self findViewById:@"message2"];
  [message1 setText:self.vamlAttrs[@"message1"]];
  [message2 setText:self.vamlAttrs[@"message2"]];
}

@end
