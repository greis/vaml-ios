#import <UIKit/UIKit.h>

@class VamlContext;

@interface UIView (Vaml)

-(void)setVamlData:(NSDictionary *)vamlData;
-(void)setVamlContext:(VamlContext *)vamlContext;

-(VamlContext *)vamlContext;
-(NSString *)vamlId;
-(NSDictionary *)vamlAttrs;

@end
