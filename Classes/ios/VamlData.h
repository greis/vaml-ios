#import <Foundation/Foundation.h>

@class VamlContext;

@interface VamlData : NSObject

-(id)initWithData:(NSDictionary *)data context:(VamlContext *)context;

-(NSString *)tag;
-(NSString *)script;
-(NSArray *)children;
-(NSArray *)classes;
-(NSDictionary *)attrs;
-(NSString *)viewId;
-(id)attrFromLocals:(NSString *)attr;
-(id)target;
-(id)objectForKeyedSubscript:(id <NSCopying>)key;

@end
