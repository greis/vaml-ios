#import "UISegmentedControl+Vaml.h"
#import "VamlContext.h"

@implementation UISegmentedControl (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  NSDictionary *attrs = data[@"attrs"];
  if (attrs[@"items"]) {
    return [self initWithItems:[context.locals valueForKeyPath:attrs[@"items"]]];
  } else {
    int i = 0;
    NSString *item;
    NSMutableArray *items = [NSMutableArray array];
    while ((item = [attrs objectForKey:[NSString stringWithFormat:@"item%d", i]])) {
      [items addObject:item];
      i++;
    }
    return [self initWithItems:items];
  }
}

@end
