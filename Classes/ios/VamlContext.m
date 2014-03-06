#import "VamlContext.h"
#import "UIView+Vaml.h"

@interface VamlContext ()
@property(nonatomic) NSMutableDictionary *views;
@end

@implementation VamlContext

-(id)init {
  self = [super init];
  if (self) {
    [self setViews:[NSMutableDictionary dictionary]];
  }
  return self;
}

-(void)addView:(UIView *)view {
  self.views[view.vamlId] = view;
}

@end
