#import "UITableView+Vaml.h"
#import "VamlData.h"

@implementation UITableView (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setDelegate:data.target];
  [self setDataSource:data.target];
  return self;
}

@end
