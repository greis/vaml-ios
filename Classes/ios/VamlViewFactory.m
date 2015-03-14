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
#import "VamlData.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation VamlViewFactory

+(UIView *)viewFromData:(VamlData *)data {
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
  
  Class class = mapping[data.tag];
  UIView *view;
  if (class) {
    view = [self vamlViewFromClass:class data:data];
  } else if ([data.tag isEqualToString:@"view"]) {
    view = [self initViewWithData:data];
  }
  
  if (view != nil) {
    [self applyCommonAttrs:data view:view];
    return view;
  } else {
    NSLog(@"Tag not implemented: %@", data.tag);
    return nil;
  }
}

# pragma mark - private

+(UIView *)vamlViewFromClass:(Class)class data:(VamlData *)data {
  SEL selector = NSSelectorFromString(@"initWithVamlData:");
  id view = [class alloc];
  if ([view respondsToSelector:selector]) {
    return [view performSelector:selector withObject:data];
  } else {
    return [view init];
  }
}

+(void)applyCommonAttrs:(VamlData *)data view:(UIView *)view {
  if ([@"true" isEqualToString:data[@"hidden"]]) {
    view.hidden = YES;
  }
  NSString *onclick = data[@"onClick"];
  if (onclick) {
    SEL selector = NSSelectorFromString(onclick);
    if ([view isKindOfClass:[UIControl class]]) {
      UIControlEvents events = [view isKindOfClass:[UISegmentedControl class]] ? UIControlEventValueChanged : UIControlEventTouchUpInside;
      [(UIControl *)view addTarget:data.target action:selector forControlEvents:events];
    } else {
      UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:data.target action:selector];
      [view addGestureRecognizer:recognizer];
    }
  }
}

+(UIView *)initViewWithData:(VamlData *)data {
  NSString *type = data[@"type"];
  if (type) {
    Class class = NSClassFromString(type);
    if (class) {
      return [self vamlViewFromClass:class data:data];
    } else {
      NSLog(@"Custom view not found: %@", type);
      return nil;
    }
  } else {
    return [UIView new];
  }
}

@end
