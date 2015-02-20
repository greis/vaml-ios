#import "UICollectionView+Vaml.h"
#import "VamlContext.h"

@implementation UICollectionView (Vaml)

-(id)initWithVamlData:(NSDictionary *)data context:(VamlContext *)context {
  NSDictionary *attrs = data[@"attrs"];
  self = [self initWithFrame:CGRectZero collectionViewLayout:[self.class collectionViewLayoutFromAttrs:attrs]];
  [self.class registerClasses:attrs collection:self];
  [self setDelegate:context.target];
  [self setDataSource:context.target];
  return self;
}

+(void)registerClasses:(NSDictionary *)attrs collection:(UICollectionView *)collection {
  NSString *cell = attrs[@"cell"];
  if (cell) {
    [[cell componentsSeparatedByString:@"|"] enumerateObjectsUsingBlock:^(NSString *pair, NSUInteger idx, BOOL *stop) {
      NSArray *components = [pair componentsSeparatedByString:@":"];
      NSString *identifier = components[0];
      NSString *cellName;
      if (components.count == 1) {
        cellName = components[0];
      } else {
        cellName = components[1];
      }
      [collection registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:identifier];
    }];
  } else {
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
  }
}

+(UICollectionViewLayout *)collectionViewLayoutFromAttrs:(NSDictionary *)attrs {
  UICollectionViewLayout *layout;
  if (attrs[@"layout"]) {
    layout = [[NSClassFromString(attrs[@"layout"]) alloc] init];
  } else {
    layout = [[UICollectionViewFlowLayout alloc] init];
    if ([@"horizontal" isEqualToString:attrs[@"scrollDirection"]]) {
      [((UICollectionViewFlowLayout *)layout) setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
  }
  return layout;
}

@end
