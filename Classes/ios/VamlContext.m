#import "VamlContext.h"
#import "UIView+Vaml.h"
#import "VamlObserver.h"

@interface VamlContext ()
@property(nonatomic) NSMutableArray *observers;
@end

@implementation VamlContext

-(void)updateLocalValue:(id)value forKeyPath:(NSString *)keyPath {
  [self.locals setValue:value forKeyPath:keyPath];
}

-(void)observeKey:(NSString *)key inView:(UIView *)view {
  VamlObserver *observer = [[VamlObserver alloc] initWithView:view key:key];
  [self addVamlObserver:observer];
  [self.locals addObserver:observer forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
}

-(void)addVamlObserver:(VamlObserver *)observer {
  if (!_observers) {
    _observers = [NSMutableArray array];
  }
  [self.observers addObject:observer];
}

-(void)dealloc {
  if (self.observers) {
    for (VamlObserver *observer in self.observers) {
      [self.locals removeObserver:observer forKeyPath:observer.key context:nil];
    }
  }
}

@end
