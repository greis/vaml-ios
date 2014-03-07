#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VamlContext : NSObject

@property(nonatomic, weak) id target;

-(NSMutableDictionary *)views;
-(void)addView:(UIView *)view;
-(UIView *)viewById:(NSString *)viewId;

@end
