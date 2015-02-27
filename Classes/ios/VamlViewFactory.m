#import "VamlViewFactory.h"
#import "VamlVerticalLayout.h"
#import "VamlHorizontalLayout.h"
#import "VamlContext.h"
#import "UITextField+Vaml.h"
#import "UIButton+Vaml.h"
#import "UILabel+Vaml.h"
#import "UISegmentedControl+Vaml.h"
#import "UITableView+Vaml.h"
#import "UICollectionView+Vaml.h"
#import "UIPickerView+Vaml.h"
#import "UIImageView+Vaml.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation VamlViewFactory

+(UIView *)viewFromData:(NSDictionary *)data context:(VamlContext *)context {
  static id mapping;
  if (!mapping) {
    mapping = @{
                @"textfield": [UITextField class],
                @"button": [UIButton class],
                @"label": [UILabel class],
                @"text": [UITextView class],
                @"segmentedcontrol": [UISegmentedControl class],
                @"vertical": [VamlVerticalLayout class],
                @"horizontal": [VamlHorizontalLayout class],
                @"table": [UITableView class],
                @"collection": [UICollectionView class],
                @"picker": [UIPickerView class],
                @"scroll": [UIScrollView class],
                @"image": [UIImageView class]
                };
  }
  
  NSString *tag = data[@"tag"];
  Class class = mapping[tag];
  UIView *view;
  if (class) {
    view = [self vamlViewFromClass:class data:data context:context];
  } else if ([tag isEqualToString:@"view"]) {
    view = [self initViewWithData:data context:context];
  }
  
  if (view != nil) {
    [self applyCommonAttrs:data[@"attrs"] view:view context:context];
    return view;
  } else {
    NSLog(@"Tag not implemented: %@", tag);
    return nil;
  }
}

# pragma mark - private

+(UIView *)vamlViewFromClass:(Class)class data:(NSDictionary *)data context:(VamlContext *)context {
  SEL selector = NSSelectorFromString(@"initWithVamlData:context:");
  id view = [class alloc];
  if ([view respondsToSelector:selector]) {
    return [view performSelector:selector withObject:data withObject:context];
  } else {
    return [view init];
  }
}

+(void)applyCommonAttrs:(NSDictionary *)attrs view:(UIView *)view context:(VamlContext *)context {
  if ([@"true" isEqualToString:attrs[@"hidden"]]) {
    view.hidden = YES;
  }
  NSString *onclick = attrs[@"onClick"];
  if (onclick) {
    SEL selector = NSSelectorFromString(onclick);
    if ([view isKindOfClass:[UIControl class]]) {
      UIControlEvents events = [view isKindOfClass:[UISegmentedControl class]] ? UIControlEventValueChanged : UIControlEventTouchUpInside;
      [(UIControl *)view addTarget:context.target action:selector forControlEvents:events];
    } else {
      UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:context.target action:selector];
      [view addGestureRecognizer:recognizer];
    }
  }
}

+(UIView *)initViewWithData:(NSDictionary *)data context:(VamlContext *)context {
  NSString *type = data[@"attrs"][@"type"];
  if (type) {
    Class class = NSClassFromString(type);
    if (class) {
      return [self vamlViewFromClass:class data:data context:context];
    } else {
      NSLog(@"Custom view not found: %@", type);
      return nil;
    }
  } else {
    return [UIView new];
  }
}

@end
