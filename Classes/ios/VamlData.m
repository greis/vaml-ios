#import "VamlData.h"
#import "VamlContext.h"
#import "VamlExpressionEvaluator.h"

@interface VamlData ()
@property(nonatomic) NSDictionary *data;
@property(nonatomic) VamlContext *context;
@end

@implementation VamlData

-(id)initWithData:(NSDictionary *)data context:(VamlContext *)context {
  self = [super init];
  if (self) {
    self.data = data;
    self.context = context;
  }
  return self;
}

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  NSString *attr = self.data[@"attrs"][key];
  return [VamlExpressionEvaluator evalExpression:attr context:self.context];
}

-(NSString *)tag {
  return self.data[@"tag"];
}

-(id)target {
  return self.context.target;
}

@end
