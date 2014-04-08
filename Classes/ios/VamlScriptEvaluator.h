#import <Foundation/Foundation.h>

@class VamlContext;

@interface VamlScriptEvaluator : NSObject

-(id)initWithContext:(VamlContext *)context;

-(void)eval:(NSString *)script successBlock:(void(^)())successBlock;
-(void)reset;

@end
