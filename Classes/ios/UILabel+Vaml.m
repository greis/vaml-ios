#import "UILabel+Vaml.h"
#import "VamlExpressionEvaluator.h"
#import "VamlContext.h"

@implementation UILabel (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  self = [self init];
  [self setText:[VamlExpressionEvaluator evalExpression:data[@"attrs"][@"text"] context:context]];
  return self;
}

@end
