#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VamlContext;

@interface VamlViewFactory : NSObject

+(UIView *)viewFromData:(NSDictionary *)data context:(VamlContext *)context;

@end
