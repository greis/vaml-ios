#import "VamlRenderer.h"
#import "Vaml.h"
#import "UIView+Vaml.h"
#import "VamlViewFactory.h"
#import "VamlScriptEvaluator.h"
#import "VamlTokenizer.h"
#import "VamlTreeBuilder.h"
#import "VamlConstraintsHandler.h"

@interface VamlRenderer ()
@property(nonatomic) NSString *vaml;
@property(nonatomic) VamlContext *context;
@property(nonatomic) VamlScriptEvaluator *scriptEvaluator;
@property(nonatomic) NSMutableArray *viewsStack;

@end
@implementation VamlRenderer

-(id)initWithView:(UIView *)view vaml:(NSString *)vaml context:(VamlContext *)context {
  self = [super init];
  if (self) {
    [self setVaml:vaml];
    [self setContext:context];
    [self setViewsStack:[NSMutableArray array]];
    [self.viewsStack addObject:view];
    [self setScriptEvaluator:[[VamlScriptEvaluator alloc] initWithContext:context]];
  }
  return self;
}

-(void)render {
  VamlTokenizer *tokenizer = [[VamlTokenizer alloc] initWithContent:self.vaml];
  NSArray *tokens = [tokenizer tokenize];
  VamlTreeBuilder *treeBuilder = [[VamlTreeBuilder alloc] initWithTokens:tokens];
  NSDictionary *tree = [treeBuilder build];
  [self setVamlData:tree];
  [VamlConstraintsHandler addConstraintsTo:self.viewsStack.firstObject];
}

-(void)setVamlData:(NSDictionary *)data {
  [self.parentView setVamlData:data];
  [self.parentView setVamlContext:self.context];
  [self handleChildren:data];
  [self.parentView didLoadFromVaml];
}

-(void)handleChildren:(NSDictionary *)data {
  [self.scriptEvaluator reset];
  for (NSDictionary *child in data[@"children"]) {
    if (child[@"tag"]) {
      [self.scriptEvaluator reset];
      UIView *subview = [VamlViewFactory viewFromData:child context:self.context];
      if (subview) {
        [self.parentView addSubview:subview];
        [self.viewsStack addObject:subview];
        [self setVamlData:child];
        [self.viewsStack removeObject:subview];
      }
    } else {
      [self.scriptEvaluator eval:child[@"script"] successBlock:^{
        [self handleChildren:child];
      }];
    }
  }
}

-(UIView *)parentView {
  return [self.viewsStack lastObject];
}

@end
