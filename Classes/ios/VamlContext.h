#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VamlContext : NSObject

-(NSMutableDictionary *)views;
-(void)addView:(UIView *)view;
-(UIView *)viewById:(NSString *)viewId;

@end
