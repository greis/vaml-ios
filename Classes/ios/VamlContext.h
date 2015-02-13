#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VamlObserver;

@interface VamlContext : NSObject

@property(nonatomic, weak) id target;
@property(nonatomic, strong) NSMutableDictionary *locals;

-(void)observeKey:(NSString *)key inView:(UIView *)view;
-(void)updateLocalValue:(id)value forKeyPath:(NSString *)keyPath;
@end
