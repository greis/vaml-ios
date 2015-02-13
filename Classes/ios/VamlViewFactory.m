#import "VamlViewFactory.h"
#import "VamlVerticalLayout.h"
#import "VamlHorizontalLayout.h"
#import "VamlContext.h"
#import "VamlCollectionInitializer.h"

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation VamlViewFactory

+(UIView *)viewFromData:(NSDictionary *)data context:(VamlContext *)context {
  NSString *tag = data[@"tag"];
  SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@WithData:context:", tag]);
  
  if ([self respondsToSelector:selector]) {
    UIView *view = [self performSelector:selector withObject:data withObject:context];
    [self applyCommonAttrs:data[@"attrs"] view:view context:context];
    return view;
  } else {
    NSLog(@"Tag not implemented: %@", tag);
    return nil;
  }
}

# pragma mark - private

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

+(UIButton *)buttonWithData:(NSDictionary *)data context:(VamlContext *)context {
  UIButton *button = [[UIButton alloc] init];
  [button setTitle:data[@"attrs"][@"title"] forState:UIControlStateNormal];
  return button;
}

+(UILabel *)labelWithData:(NSDictionary *)data context:(VamlContext *)context {
  UILabel *label = [[UILabel alloc] init];
  [label setText:[self evalExpression:data[@"attrs"][@"text"] context:context]];
  return label;
}

+(UITextField *)textfieldWithData:(NSDictionary *)data context:(VamlContext *)context {
  UITextField *textField = [[UITextField alloc] init];
  [textField setPlaceholder:[self evalExpression:data[@"attrs"][@"placeholder"] context:context]];
  [textField setText:[self evalExpression:data[@"attrs"][@"text"] context:context]];
  return textField;
}

+(UITextView *)textWithData:(NSDictionary *)data context:(VamlContext *)context {
  UITextView *textView = [[UITextView alloc] init];
  return textView;
}

+(UISegmentedControl *)segmentedcontrolWithData:(NSDictionary *)data context:(VamlContext *)context {
  int i = 0;
  NSString *item;
  NSMutableArray *items = [NSMutableArray array];
  while ((item = [data[@"attrs"] objectForKey:[NSString stringWithFormat:@"item%d", i]])) {
    [items addObject:item];
    i++;
  }
  UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:items];
  return control;
}

+(VamlHorizontalLayout *)horizontalWithData:(NSDictionary *)data context:(VamlContext *)context {
  return [[VamlHorizontalLayout alloc] init];
}

+(VamlVerticalLayout *)verticalWithData:(NSDictionary *)data context:(VamlContext *)context {
  return [[VamlVerticalLayout alloc] init];
}

+(UIView *)viewWithData:(NSDictionary *)data context:(VamlContext *)context {
  NSString *type = data[@"attrs"][@"type"];
  if (type) {
    Class class = NSClassFromString(type);
    if (class) {
      return [[class alloc] init];
    } else {
      NSLog(@"Custom view not found: %@", type);
      return nil;
    }
  } else {
    return [[UIView alloc] init];
  }
}

+(UITableView *)tableWithData:(NSDictionary *)data context:(VamlContext *)context {
  UITableView *table = [[UITableView alloc] init];
  [table setDelegate:context.target];
  [table setDataSource:context.target];
  return table;
}

+(UIPickerView *)pickerWithData:(NSDictionary *)data context:(VamlContext *)context {
  UIPickerView *picker = [[UIPickerView alloc] init];
  [picker setDelegate:context.target];
  [picker setDataSource:context.target];
  return picker;
}

+(UIView *)collectionWithData:(NSDictionary *)data context:(VamlContext *)context {
  return [VamlCollectionInitializer viewFromData:data context:context];
}

+(UIView *)scrollWithData:(NSDictionary *)data context:(VamlContext *)context {
  return [[UIScrollView alloc] init];
}

+(UIView *)imageWithData:(NSDictionary *)data context:(VamlContext *)context {
  NSString *imageName = data[@"attrs"][@"name"];
  return [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}

+(NSString *)evalExpression:(NSString *)expression context:(VamlContext *)context {
  if (!expression) return nil;
  static NSRegularExpression *regex;
  if (!regex) {
    regex = [NSRegularExpression regularExpressionWithPattern:@"#\\{(.*?)\\}" options:0 error:nil];
  }
  
  NSMutableString* mutableString = [expression mutableCopy];
  NSInteger offset = 0;
  for (NSTextCheckingResult* result in [regex matchesInString:expression
                                                      options:0
                                                        range:NSMakeRange(0, expression.length)]) {
    NSRange resultRange = [result rangeAtIndex:0];
    resultRange.location += offset;
    NSString* match = [regex replacementStringForResult:result
                                               inString:mutableString
                                                 offset:offset
                                               template:@"$1"];
    NSString *replacement = @"";
    id value = [context.locals valueForKeyPath:match];
    if ([value respondsToSelector:@selector(stringValue)]) {
      replacement = [value stringValue];
    } else if ([value isKindOfClass:[NSString class]]) {
      replacement = value;
    }
    
    [mutableString replaceCharactersInRange:resultRange withString:replacement];
    offset += ([replacement length] - resultRange.length);
  }
  
  return mutableString;
}

@end
