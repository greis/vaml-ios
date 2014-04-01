#import <UIKit/UIKit.h>

@class VamlContext;

@interface UIView (Vaml)

@property(nonatomic) NSDictionary *vamlData;
@property(nonatomic) VamlContext *vamlContext;

@end
