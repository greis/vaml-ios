#import "UITableView+Vaml.h"
#import "VamlContext.h"

@implementation UITableView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  self = [self init];
  [self setDelegate:context.target];
  [self setDataSource:context.target];
  return self;
}

@end
