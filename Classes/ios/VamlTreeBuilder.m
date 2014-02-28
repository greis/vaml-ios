#import "VamlTreeBuilder.h"

@interface VamlTreeBuilder ()
@property(nonatomic, strong) NSArray *tokens;
@property(nonatomic) int nextIndex;
@property(nonatomic) NSString *firstIndentation;
@end

@implementation VamlTreeBuilder

-(id)initWithTokens:(NSArray *)tokens {
  self = [super init];
  if (self) {
    [self setTokens:tokens];
  }
  return self;
}

-(NSDictionary *)build {
  NSMutableDictionary *tree = [self nextToken];
  [self addChildren:tree];
  return tree;
}

-(void)addChildren:(NSMutableDictionary *)parent {
  while ([self nextTokenIsChildren:parent]) {
    NSMutableDictionary *child = [self nextToken];
    if (child) {
      if (parent[@"children"] == nil) {
        parent[@"children"] = [NSMutableArray array];
      }
      
      [parent[@"children"] addObject:child];
      [self addChildren:child];
    }
  }
}

-(BOOL)nextTokenIsChildren:(NSMutableDictionary *)parent {
  if (self.nextIndex == self.tokens.count)
    return NO;
  
  NSDictionary *token = self.tokens[self.nextIndex];
  if (self.firstIndentation == nil) {
    self.firstIndentation = token[@"indentation"];
    return YES;
  } else {
    int indent = [token[@"indentation"] length] / self.firstIndentation.length;
    int parentIndent = [parent[@"indentation"] length] / self.firstIndentation.length;
    return parentIndent == indent - 1;
  }
}

-(NSMutableDictionary *)nextToken {
  NSDictionary *token = self.tokens[self.nextIndex];
  self.nextIndex++;
  if ([token isKindOfClass:[NSMutableDictionary class]]) {
    return (NSMutableDictionary *)token;
  } else {
    return [NSMutableDictionary dictionaryWithDictionary:token];
  }
}


@end
