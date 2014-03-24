#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VamlContext.h"

@interface VamlCollectionInitializer : NSObject

+(UIView *)viewFromData:(NSDictionary *)data context:(VamlContext *)context;

@end
