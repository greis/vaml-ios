#import "UISegmentedControl+Vaml.h"
#import "VamlContext.h"

@implementation UISegmentedControl (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  int i = 0;
  NSString *item;
  NSMutableArray *items = [NSMutableArray array];
  while ((item = [data[@"attrs"] objectForKey:[NSString stringWithFormat:@"item%d", i]])) {
    [items addObject:item];
    i++;
  }
  return [self initWithItems:items];
}

@end
