#import "UICollectionView+Vaml.h"
#import "VamlData.h"

@implementation UICollectionView (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self initWithFrame:CGRectZero collectionViewLayout:[self.class collectionViewLayoutFromData:data]];
  [self.class registerClasses:data collection:self];
  [self setDelegate:data.target];
  [self setDataSource:data.target];
  return self;
}

+(void)registerClasses:(VamlData *)data collection:(UICollectionView *)collection {
  NSString *cell = data[@"cell"];
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

+(UICollectionViewLayout *)collectionViewLayoutFromData:(VamlData *)data {
  UICollectionViewLayout *layout;
  if (data[@"layout"]) {
    layout = [[NSClassFromString(data[@"layout"]) alloc] init];
  } else {
    layout = [[UICollectionViewFlowLayout alloc] init];
    if ([@"horizontal" isEqualToString:data[@"scrollDirection"]]) {
      [((UICollectionViewFlowLayout *)layout) setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
  }
  return layout;
}

@end
