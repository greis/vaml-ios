#import "UISegmentedControl+Vaml.h"
#import "VamlData.h"

@implementation UISegmentedControl (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  NSArray *items = data[@"items"];
  if (items) {
    return [self initWithItems:items];
  } else {
    int i = 0;
    NSString *item;
    NSMutableArray *items = [NSMutableArray array];
    while ((item = data[[NSString stringWithFormat:@"item%d", i]])) {
      [items addObject:item];
      i++;
    }
    return [self initWithItems:items];
  }
}

@end
