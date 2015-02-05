#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VamlContext : NSObject

@property(nonatomic, weak) id target;
@property(nonatomic, strong) NSMutableDictionary *locals;

@end
