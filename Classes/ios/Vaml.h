#import <Foundation/Foundation.h>

@interface Vaml : NSObject

@end

@interface UIView (VamlExtension)

-(NSString *)vamlId;
-(NSDictionary *)vamlAttrs;
-(void)applyVamlLayout:(NSString *)layout;
-(UIView *)findViewById:(NSString *)viewId;
-(void)didLoadFromVaml;

@end

@interface UIViewController (VamlExtension)

-(void)applyVamlLayout:(NSString *)layout;
-(UIView *)findViewById:(NSString *)viewId;

@end