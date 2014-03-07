#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VamlViewFactory : NSObject

+(UIView *)viewFromData:(NSDictionary *)data;

@end
