#import <UIKit/UIKit.h>

@class VamlContext;

@interface UICollectionView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context;

@end