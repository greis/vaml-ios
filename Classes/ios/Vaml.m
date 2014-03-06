#import "Vaml.h"
#import "VamlHorizontalLayout.h"
#import "VamlVerticalLayout.h"
#import "VamlTokenizer.h"
#import "VamlTreeBuilder.h"
#import "UIView+Vaml.h"
#import "VamlContext.h"
#import "VamlConstraintsHandler.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation Vaml

+(void)layout:(NSString *)layout view:(UIView *)view {
  VamlTokenizer *tokenizer = [[VamlTokenizer alloc] initWithFileName:layout extension:@"vaml"];
  NSArray *tokens = [tokenizer tokenize];
  VamlTreeBuilder *treeBuilder = [[VamlTreeBuilder alloc] initWithTokens:tokens];
  NSDictionary *tree = [treeBuilder build];
  VamlContext *context = [[VamlContext alloc] init];
  [context addView:view];
  [self addChildren:tree[@"children"] to:view context:context];
  [VamlConstraintsHandler addConstraintsTo:view context:context];
}

+(void)addChildren:(NSArray *)children to:(UIView *)view context:(VamlContext *)context {
  for (NSDictionary *child in children) {
    UIView *subview = [self viewFromData:child];
    [view addSubview:subview];
    [context addView:subview];
    if (child[@"children"]) {
      [self addChildren:child[@"children"] to:subview context:context];
    }
  }
  SEL selector = NSSelectorFromString(@"didAddAllSubviews");
  if ([view respondsToSelector:selector]) {
    [view performSelector:selector];
  }
}

+(UIView *)viewFromData:(NSDictionary *)data {
  //TODO create factory class
  NSString *tag = data[@"tag"];
  UIView *view;
  if ([tag isEqualToString:@"label"]) {
    UILabel *label = [[UILabel alloc] init];
    [label setText:data[@"attrs"][@"text"]];
    view = label;
  } else if ([tag isEqualToString:@"textfield"]) {
    UITextField *textField = [[UITextField alloc] init];
    view = textField;
  } else if ([tag isEqualToString:@"button"]) {
    UIButton *button = [[UIButton alloc] init];
    view = button;
  } else if ([tag isEqualToString:@"horizontal"]) {
    VamlHorizontalLayout *layout = [[VamlHorizontalLayout alloc] init];
    view = layout;
  } else if ([tag isEqualToString:@"vertical"]) {
    VamlVerticalLayout *layout = [[VamlVerticalLayout alloc] init];
    view = layout;
  } else {
    view = [[UIView alloc] init];
    NSLog(@"tag not implemented: %@", tag);
  }
  
  [view setVamlData:data];
  return view;
}

@end
