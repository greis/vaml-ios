#import "UIView+Vaml.h"
#import <objc/runtime.h>

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation UIView (Vaml)

static char const * const VamlDataKey = "VamlData";
static char const * const VamlContextKey = "VamlContext";

-(void)setVamlData:(NSDictionary *)vamlData {
  objc_setAssociatedObject(self, VamlDataKey, vamlData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self setPixateAttributes];
}

-(void)setVamlContext:(VamlContext *)vamlContext {
  objc_setAssociatedObject(self, VamlContextKey, vamlContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(VamlContext *)vamlContext {
  return objc_getAssociatedObject(self, VamlContextKey);
}

#pragma mark - private

-(NSDictionary *)vamlData {
  return objc_getAssociatedObject(self, VamlDataKey);
}

-(void)setPixateAttributes {
  BOOL pixatePresent = NSClassFromString(@"PixateFreestyle") != nil;
  if (pixatePresent) {
    if (self.vamlData[@"id"]) {
      SEL selector = NSSelectorFromString(@"setStyleId:");
      [self performSelector:selector withObject:self.vamlData[@"id"]];
    }
    if (self.vamlData[@"classes"]) {
      SEL selector = NSSelectorFromString(@"setStyleClass:");
      [self performSelector:selector withObject:[self.vamlData[@"classes"] componentsJoinedByString:@" "]];
    }
  }
}

@end
