#import "VamlAttributesParser.h"

@interface VamlAttributesParser ()
@property(nonatomic) NSString *string;
@end

@implementation VamlAttributesParser

-(id)initWithString:(NSString *)string {
  self = [super init];
  if (self) {
    [self setString:string];
  }
  return self;
}

-(NSDictionary *)parseString {
  NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
  
  static NSRegularExpression *regex;
  if (!regex) {
    regex = [NSRegularExpression regularExpressionWithPattern:@"(\\w+)\\s*[:=]\\s*(\"[^\"]*\"|'[^']*')" options:0 error:nil];
  }
  [regex enumerateMatchesInString:self.string options:0 range:NSMakeRange(1, self.string.length - 1) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
    NSString *key = [self.string substringWithRange:[result rangeAtIndex:1]];
    NSRange valueRange = [result rangeAtIndex:2];
    NSString *value = [self.string substringWithRange:NSMakeRange(valueRange.location + 1, valueRange.length - 2)];
    attributes[key] = value;
  }];
  
  return attributes;
}

@end
