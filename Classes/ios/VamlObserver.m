#import "VamlObserver.h"

@interface VamlObserver ()
@property(nonatomic) UIView *view;
@property(nonatomic, copy) NSString *key;
@end

@implementation VamlObserver

-(id)initWithView:(UIView *)view key:(NSString *)key {
  self = [super init];
  if (self) {
    [self setView:view];
    [self setKey:key];
  }
  return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  UILabel *label = (UILabel *) self.view;
  label.text = change[NSKeyValueChangeNewKey];
}

@end
