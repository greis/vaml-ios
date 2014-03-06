#import "UIView+Vaml.h"
#import <objc/runtime.h>

@implementation UIView (Vaml)

static char const * const VamlDataKey = "VamlData";

-(void)setVamlData:(NSDictionary *)vamlData {
  objc_setAssociatedObject(self, VamlDataKey, vamlData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)vamlData {
  return objc_getAssociatedObject(self, VamlDataKey);
}

-(NSString *)vamlId {
  NSString *identifier = self.vamlData[@"id"];
  if (!identifier) {
    identifier = [NSString stringWithFormat:@"%@_%d", self.class, self.hash];
  }
  return identifier;
}

-(NSDictionary *)vamlAttrs {
  NSDictionary *attrs = self.vamlData[@"attrs"];
  return attrs ? attrs : @{};
}


@end
