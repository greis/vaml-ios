#import "Vaml.h"
#import "VamlTokenizer.h"
#import "VamlTreeBuilder.h"
#import "UIView+Vaml.h"
#import "VamlContext.h"
#import "VamlConstraintsHandler.h"
#import "VamlViewFactory.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation Vaml

+(void)layout:(NSString *)layout view:(UIView *)view {
  VamlTokenizer *tokenizer = [[VamlTokenizer alloc] initWithFileName:layout extension:@"vaml"];
  NSArray *tokens = [tokenizer tokenize];
  VamlTreeBuilder *treeBuilder = [[VamlTreeBuilder alloc] initWithTokens:tokens];
  NSDictionary *tree = [treeBuilder build];
  VamlContext *context = [[VamlContext alloc] init];
  [self setVamlData:tree to:view context:context];
  [VamlConstraintsHandler addConstraintsTo:view context:context];
}

+(void)setVamlData:(NSDictionary *)data to:(UIView *)view context:(VamlContext *)context {
  [view setVamlData:data];
  [context addView:view];
  NSArray *children = data[@"children"];
  if (children) {
    for (NSDictionary *child in children) {
      UIView *subview = [VamlViewFactory viewFromData:child];
      [view addSubview:subview];
      [self setVamlData:child to:subview context:context];
    }
    SEL selector = NSSelectorFromString(@"didAddAllSubviews");
    if ([view respondsToSelector:selector]) {
      [view performSelector:selector];
    }
  }
}


@end
