#import "VamlViewFactory.h"
#import "VamlVerticalLayout.h"
#import "VamlHorizontalLayout.h"

@implementation VamlViewFactory

+(UIView *)viewFromData:(NSDictionary *)data {
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
  return view;
}

@end
