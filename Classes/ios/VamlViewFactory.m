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
    return [self performSelector:selector withObject:data withObject:context];
  } else {
    NSLog(@"Tag not implemented: %@", tag);
    return nil;
  }
}

# pragma mark - private

+(UIButton *)buttonWithData:(NSDictionary *)data context:(VamlContext *)context {
  UIButton *button = [[UIButton alloc] init];
  NSString *onclick = data[@"attrs"][@"onClick"];
  if (onclick) {
    SEL selector = NSSelectorFromString(onclick);
    [button addTarget:context.target action:selector forControlEvents:UIControlEventTouchUpInside];
  }
  return button;
}

+(UILabel *)labelWithData:(NSDictionary *)data context:(VamlContext *)context {
  UILabel *label = [[UILabel alloc] init];
  [label setText:data[@"attrs"][@"text"]];
  return label;
}

+(UITextField *)textfieldWithData:(NSDictionary *)data context:(VamlContext *)context {
  UITextField *textField = [[UITextField alloc] init];
  [textField setPlaceholder:data[@"attrs"][@"placeholder"]];
  return textField;
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
  Class class = NSClassFromString(type);
  if (class) {
    return [[class alloc] init];
  } else {
    NSLog(@"Custom view not found: %@", type);
    return nil;
  }
}

+(UITableView *)tableWithData:(NSDictionary *)data context:(VamlContext *)context {
  UITableView *table = [[UITableView alloc] init];
  [table setDelegate:context.target];
  [table setDataSource:context.target];
  return table;
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

@end
