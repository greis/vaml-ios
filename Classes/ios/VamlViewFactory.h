#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class VamlData;

@interface VamlViewFactory : NSObject

+(UIView *)viewFromData:(VamlData *)data;

@end
