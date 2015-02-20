#import <UIKit/UIKit.h>

@class VamlContext;

@interface UITableView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end
