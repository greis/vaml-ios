#import "VamlScriptEvaluator.h"
#import "VamlContext.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface VamlScriptEvaluator ()

@property(nonatomic) BOOL previousIf;
@property(nonatomic) BOOL lastConditionValue;
@property(nonatomic) JSContext *jsContext;

@end

typedef enum : NSUInteger {
  VamlStatementIf,
  VamlStatementElsif,
  VamlStatementElse,
} VamlStatement;

@interface VamlScript : NSObject
@property(nonatomic, strong) NSString *expression;
@property(nonatomic) VamlStatement statement;
-(id)initWithScript:(NSString *)script;

@end

@implementation VamlScript

-(id)initWithScript:(NSString *)script {
  self = [super init];
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^-\\s*(if|else|elsif)(.*$)" options:0 error:nil];
  [regex enumerateMatchesInString:script options:0 range:NSMakeRange(0, script.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
    NSString *statement = [script substringWithRange:[result rangeAtIndex:1]];
    if ([statement isEqualToString:@"if"]) {
      self.statement = VamlStatementIf;
    } else if ([statement isEqualToString:@"elsif"]) {
      self.statement = VamlStatementElsif;
    } else if ([statement isEqualToString:@"else"]) {
      self.statement = VamlStatementElse;
    }
    self.expression = [script substringWithRange:[result rangeAtIndex:2]];
  }];
  return self;
}

@end

@implementation VamlScriptEvaluator

-(id)initWithContext:(VamlContext *)context {
  self = [super init];
  if (self) {
    [self setJsContext:[[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]]];
    
    if (context.locals) {
      [context.locals enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        self.jsContext[key] = obj;
      }];
    }
  }
  return self;
}

-(void)eval:(NSString *)text successBlock:(void (^)())successBlock {
  VamlScript *script = [[VamlScript alloc] initWithScript:text];
  
  if (script.statement == VamlStatementIf) {
    self.lastConditionValue = [self evalCondition:script.expression successBlock:successBlock];
    self.previousIf = YES;
  } else if(self.previousIf && !self.lastConditionValue && script.statement == VamlStatementElsif) {
    self.lastConditionValue = [self evalCondition:script.expression successBlock:successBlock];
  } else if(self.previousIf && !self.lastConditionValue && script.statement == VamlStatementElse) {
    successBlock();
    self.previousIf = NO;
  }
}

-(void)reset {
  self.previousIf = NO;
}

-(BOOL)evalCondition:(NSString *)script successBlock:(void(^)())successBlock {
  JSValue *value = [self.jsContext evaluateScript:script];
  BOOL result = [value toBool];
  if (result) {
    successBlock();
  }
  return result;
}

@end
