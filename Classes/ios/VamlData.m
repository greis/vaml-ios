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
  NSString *attr = self.attrs[key];
  return [VamlExpressionEvaluator evalExpression:attr context:self.context];
}

-(id)attrFromLocals:(NSString *)attr {
  return [self.context.locals valueForKeyPath:self.attrs[attr]];
}

-(NSString *)tag {
  return self.data[@"tag"];
}

-(NSString *)script {
  return self.data[@"script"];
}

-(NSString *)viewId {
  return self.data[@"id"];
}

-(NSArray *)classes {
  return self.data[@"classes"];
}

-(NSDictionary *)attrs {
  return self.data[@"attrs"];
}

-(NSArray *)children {
  NSMutableArray *childrenData = [NSMutableArray array];
  for (NSDictionary *child in self.data[@"children"]) {
    VamlData *data = [[VamlData alloc] initWithData:child context:self.context];
    [childrenData addObject:data];
  }
  return childrenData;
}

-(id)target {
  return self.context.target;
}

@end
