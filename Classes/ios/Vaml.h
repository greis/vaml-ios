#import <Foundation/Foundation.h>
#import "VamlData.h"

@interface Vaml : NSObject

@end

@interface UIView (VamlExtension)

@property(nonatomic) VamlData *vamlData;
-(NSString *)vamlId;
-(void)applyVamlLayout:(NSString *)layout;
-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals;
-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals target:(id)target;
-(UIView *)findViewById:(NSString *)viewId;
-(NSArray *)findViewsByClass:(NSString *)cssClass;
-(void)didLoadFromVaml;

@end

@interface UIViewController (VamlExtension)

-(void)applyVamlLayout:(NSString *)layout;
-(void)applyVamlLayout:(NSString *)layout locals:(NSDictionary *)locals;
-(UIView *)findViewById:(NSString *)viewId;
-(NSArray *)findViewsByClass:(NSString *)cssClass;

@end