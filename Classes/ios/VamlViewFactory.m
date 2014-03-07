#import "VamlViewFactory.h"
#import "VamlVerticalLayout.h"
#import "VamlHorizontalLayout.h"
#import "VamlContext.h"

@implementation VamlViewFactory

+(UIView *)viewFromData:(NSDictionary *)data context:(VamlContext *)context {
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
    view = [self buttonFromData:data context:context];
  } else if ([tag isEqualToString:@"horizontal"]) {
    VamlHorizontalLayout *layout = [[VamlHorizontalLayout alloc] init];
    view = layout;
  } else if ([tag isEqualToString:@"vertical"]) {
    VamlVerticalLayout *layout = [[VamlVerticalLayout alloc] init];
    view = layout;
  } else if ([tag isEqualToString:@"view"]) {
    NSString *type = data[@"attrs"][@"type"];
    Class class = NSClassFromString(type);
    if (class) {
      view = [[class alloc] init];
    } else {
      NSLog(@"Custom view not found: %@", type);
    }
  } else {
    NSLog(@"Tag not implemented: %@", tag);
  }
  return view;
}

+(UIButton *)buttonFromData:(NSDictionary *)data context:(VamlContext *)context {
  UIButton *button = [[UIButton alloc] init];
  NSString *onclick = data[@"attrs"][@"onclick"];
  if (onclick) {
    SEL selector = NSSelectorFromString(onclick);
    [button addTarget:context.target action:selector forControlEvents:UIControlEventTouchUpInside];
  }
  return button;
}

@end
