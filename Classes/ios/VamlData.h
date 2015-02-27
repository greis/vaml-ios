#import <Foundation/Foundation.h>

@class VamlContext;

@interface VamlData : NSObject

-(id)initWithData:(NSDictionary *)data context:(VamlContext *)context;

-(NSString *)tag;
-(id)target;
-(id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
