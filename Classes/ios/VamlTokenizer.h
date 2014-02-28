#import <Foundation/Foundation.h>

@interface VamlTokenizer : NSObject

-(id)initWithContent:(NSString *)content;
-(id)initWithFileName:(NSString *)fileName extension:(NSString *)extension;

-(NSArray *)tokenize;

@end
