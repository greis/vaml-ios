#import <Foundation/Foundation.h>

@interface VamlTokenizer : NSObject

-(id)initWithContent:(NSString *)content;

-(NSArray *)tokenize;

@end
