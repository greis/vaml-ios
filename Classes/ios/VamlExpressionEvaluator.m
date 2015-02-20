#import "VamlExpressionEvaluator.h"
#import "VamlContext.h"

@implementation VamlExpressionEvaluator

+(NSString *)evalExpression:(NSString *)expression context:(VamlContext *)context {
  if (!expression) return nil;
  static NSRegularExpression *regex;
  if (!regex) {
    regex = [NSRegularExpression regularExpressionWithPattern:@"#\\{(.*?)\\}" options:0 error:nil];
  }
  
  NSMutableString* mutableString = [expression mutableCopy];
  NSInteger offset = 0;
  for (NSTextCheckingResult* result in [regex matchesInString:expression
                                                      options:0
                                                        range:NSMakeRange(0, expression.length)]) {
    NSRange resultRange = [result rangeAtIndex:0];
    resultRange.location += offset;
    NSString* match = [regex replacementStringForResult:result
                                               inString:mutableString
                                                 offset:offset
                                               template:@"$1"];
    NSString *replacement = @"";
    id value = [context.locals valueForKeyPath:match];
    if ([value respondsToSelector:@selector(stringValue)]) {
      replacement = [value stringValue];
    } else if ([value isKindOfClass:[NSString class]]) {
      replacement = value;
    }
    
    [mutableString replaceCharactersInRange:resultRange withString:replacement];
    offset += ([replacement length] - resultRange.length);
  }
  
  return mutableString;
}

@end
