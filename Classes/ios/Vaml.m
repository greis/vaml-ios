#import "Vaml.h"
#import "VamlContext.h"
#import "VamlRenderer.h"
#import <objc/runtime.h>

@implementation Vaml

+(void)layout:(NSString *)layout view:(UIView *)view target:(id)target locals:(NSDictionary *)locals {
  VamlContext *context = [[VamlContext alloc] init];
  [context setTarget:target];
  [context setLocals:[NSMutableDictionary dictionaryWithDictionary:locals ?: @{}]];
  NSString* fileRoot = [[NSBundle mainBundle] pathForResource:layout ofType:@"vaml"];
  NSString* fileContent = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
  VamlRenderer *renderer = [[VamlRenderer alloc] initWithView:view vaml:fileContent context:context];
  [renderer render];
}

@end

@implementation UIView (VamlExtension)

static char const * const VamlDataKey = "VamlData";

-(void)setVamlData:(VamlData *)vamlData {
  objc_setAssociatedObject(self, VamlDataKey, vamlData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(VamlData *)vamlData {
  return objc_getAssociatedObject(self, VamlDataKey);
}

-(void)applyVamlLayout:(NSString *)layout {
  [self applyVamlLayout:layout locals:nil];
}

-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals {
  [Vaml layout:layout view:self target:self locals:locals];
}

-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals target:(id)target {
  [Vaml layout:layout view:self target:target locals:locals];
}

-(UIView *)findViewById:(NSString *)viewId {
  if ([self.vamlId isEqualToString:viewId]) {
    return self;
  } else {
    for (UIView *subview in self.subviews) {
      id result = [subview findViewById:viewId];
      if (result) return result;
    }
    return nil;
  }
}

-(NSArray *)findViewsByClass:(NSString *)cssClass {
  NSMutableArray *array = [NSMutableArray array];
  [self findByClass:cssClass views:array];
  return array;
}

-(void)findByClass:(NSString *)cssClass views:(NSMutableArray *)array {
  NSArray *classes = self.vamlData.classes;
  if ([classes containsObject:cssClass]) {
    [array addObject:self];
  }
  for (UIView *subview in self.subviews) {
    [subview findByClass:cssClass views:array];
  }
}

-(NSString *)vamlId {
  NSString *identifier = self.vamlData.viewId;
  if (!identifier) {
    identifier = self.vamlData.tag;
    if (!identifier) { identifier = @"view"; }
    identifier = [NSString stringWithFormat:@"%@_%d", identifier, abs(self.hash)];
  }
  return identifier;
}

-(void)didLoadFromVaml {}

@end

@implementation UIViewController (VamlExtension)

-(void)applyVamlLayout:(NSString *)layout {
  [self applyVamlLayout:layout locals:nil];
}

-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals {
  [Vaml layout:layout view:self.view target:self locals:locals];
}

-(UIView *)findViewById:(NSString *)viewId {
  return [self.view findViewById:viewId];
}

-(NSArray *)findViewsByClass:(NSString *)cssClass {
  return [self.view findViewsByClass:cssClass];
}

@end
