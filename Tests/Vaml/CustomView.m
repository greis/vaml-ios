#import "CustomView.h"

@implementation CustomView

- (id)init {
  self = [super init];
  if (self) {
    [self setBackgroundColor:[UIColor redColor]];
    [self.layer setCornerRadius:25];
  }
  return self;
}

-(CGSize)intrinsicContentSize {
  return CGSizeMake(50, 50);
}

@end
