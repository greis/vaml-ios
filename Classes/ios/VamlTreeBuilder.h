#import <Foundation/Foundation.h>

@interface VamlTreeBuilder : NSObject

-(id)initWithTokens:(NSArray *)tokens;

-(NSDictionary *)build;
@end
