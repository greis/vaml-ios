#import <Foundation/Foundation.h>

@interface Vaml : NSObject

@end

@interface UIView (VamlExtension)

-(void)applyVamlLayout:(NSString *)layout;
-(UIView *)findViewById:(NSString *)viewId;

@end

@interface UIViewController (VamlExtension)

-(void)applyVamlLayout:(NSString *)layout;
-(UIView *)findViewById:(NSString *)viewId;

@end