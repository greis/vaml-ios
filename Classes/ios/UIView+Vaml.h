#import <UIKit/UIKit.h>

@interface UIView (Vaml)

@property(nonatomic) NSDictionary *vamlData;

-(NSString *)vamlId;

-(NSDictionary *)vamlAttrs;

@end
