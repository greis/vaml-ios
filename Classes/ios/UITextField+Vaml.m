#import "UITextField+Vaml.h"
#import "UIView+Vaml.h"
#import "VamlContext.h"
#import "VamlExpressionEvaluator.h"

@implementation UITextField (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  self = [self init];
  [self setPlaceholder:[VamlExpressionEvaluator evalExpression:data[@"attrs"][@"placeholder"] context:context]];
  [self setText:[VamlExpressionEvaluator evalExpression:data[@"attrs"][@"text"] context:context]];
  return self;
}

@end
