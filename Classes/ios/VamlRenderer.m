#import "VamlRenderer.h"
#import "Vaml.h"
#import "VamlViewFactory.h"
#import "VamlScriptEvaluator.h"
#import "VamlTokenizer.h"
#import "VamlTreeBuilder.h"
#import "VamlConstraintsHandler.h"
#import "VamlData.h"

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
  VamlData *data = [[VamlData alloc] initWithData:tree context:self.context];
  [self setVamlData:data];
  [VamlConstraintsHandler addConstraintsTo:self.viewsStack.firstObject];
}

-(void)setVamlData:(VamlData *)data {
  [self.parentView setVamlData:data];
  [self setPixateAttributes];
  [self handleChildren:data];
  [self.parentView didLoadFromVaml];
}

-(void)handleChildren:(VamlData *)data {
  [self.scriptEvaluator reset];
  for (VamlData *child in data.children) {
    if (child.tag) {
      [self.scriptEvaluator reset];
      UIView *subview = [VamlViewFactory viewFromData:child];
      if (subview) {
        [self.parentView addSubview:subview];
        [self.viewsStack addObject:subview];
        [self setVamlData:child];
        [self.viewsStack removeObject:subview];
      }
    } else {
      [self.scriptEvaluator eval:child.script successBlock:^{
        [self handleChildren:child];
      }];
    }
  }
}

-(UIView *)parentView {
  return [self.viewsStack lastObject];
}

-(void)setPixateAttributes {
  UIView *view = self.parentView;
  BOOL pixatePresent = NSClassFromString(@"PixateFreestyle") != nil;
  if (pixatePresent) {
    if (view.vamlData.viewId) {
      SEL selector = NSSelectorFromString(@"setStyleId:");
      void (*func)(id, SEL, NSString *) = (void *)[view methodForSelector:selector];
      func(view, selector, view.vamlData.viewId);
    }
    if (view.vamlData.classes) {
      SEL selector = NSSelectorFromString(@"setStyleClass:");
      void (*func)(id, SEL, NSString *) = (void *)[view methodForSelector:selector];
      func(view, selector, [view.vamlData.classes componentsJoinedByString:@" "]);
    }
  }
}


@end
