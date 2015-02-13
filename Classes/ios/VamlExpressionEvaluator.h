#import <Foundation/Foundation.h>

@class VamlContext;

@interface VamlExpressionEvaluator : NSObject

+(NSString *)evalExpression:(NSString *)expression context:(VamlContext *)context;

@end
