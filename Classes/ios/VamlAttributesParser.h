#import <Foundation/Foundation.h>

@interface VamlAttributesParser : NSObject

-(id)initWithString:(NSString *)string;

-(NSDictionary *)parseString;
@end
