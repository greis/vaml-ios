#import "Kiwi.h"
#import "VamlCollectionInitializer.h"
#import "VamlContext.h"
#import <objc/runtime.h>

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

@interface CustomLayout : UICollectionViewFlowLayout
@end
@implementation CustomLayout
@end

@interface CustomCell : UICollectionViewCell
@end
@implementation CustomCell
@end

@interface UICollectionView (Spec)
-(NSMutableDictionary *)identifiers;
@end

@implementation UICollectionView (Spec)
-(void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
  self.identifiers[identifier] = cellClass;
}

-(NSMutableDictionary *)identifiers {
  NSMutableDictionary *dict = objc_getAssociatedObject(self, "identifiers");
  if (!dict) {
    dict = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, "identifiers", dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  return dict;
}
@end

SPEC_BEGIN(VamlCollectionInitializerSpec)

let(attrs, ^id{ return @{}; });
let(data, ^id{ return @{@"tag": @"collection", @"attrs": attrs}; });
let(vamlContext, ^id{ return [[VamlContext alloc] init]; });
let(subject, ^id{ return [VamlCollectionInitializer viewFromData:data context:vamlContext]; });

context(@"without layout", ^{
  context(@"without scrollDirection", ^{
    it(@"uses the flow layout", ^{
      [[[[subject collectionViewLayout] class] should] equal:[UICollectionViewFlowLayout class]];
    });
    it(@"scrolls on the vertical direction", ^{
      [[theValue([(UICollectionViewFlowLayout *)[subject collectionViewLayout] scrollDirection]) should] equal:theValue(UICollectionViewScrollDirectionVertical)];
    });
  });
  
  context(@"with horizontal scrollDirection", ^{
    let(attrs, ^id{ return @{@"scrollDirection": @"horizontal"}; });
    it(@"uses the flow layout", ^{
      [[[[subject collectionViewLayout] class] should] equal:[UICollectionViewFlowLayout class]];
    });
    it(@"scrolls on the vertical direction", ^{
      [[theValue([(UICollectionViewFlowLayout *)[subject collectionViewLayout] scrollDirection]) should] equal:theValue(UICollectionViewScrollDirectionHorizontal)];
    });
  });
});

context(@"with layout", ^{
  let(attrs, ^id{ return @{@"layout": @"CustomLayout"}; });
  it(@"uses the custom layout", ^{
    [[[[subject collectionViewLayout] class] should] equal:[CustomLayout class]];
  });
});

context(@"without cell", ^{
  it(@"registers UICollectionViewCell class and identifier", ^{
    [[[subject identifiers] should] equal:@{@"UICollectionViewCell": [UICollectionViewCell class]}];
  });
});

context(@"with single cell", ^{
  context(@"without identifier", ^{
    let(attrs, ^id{ return @{@"cell": @"CustomCell"}; });
    it(@"registers the custom class and identifier", ^{
      [[[subject identifiers] should] equal:@{@"CustomCell": [CustomCell class]}];
    });
  });
  
  context(@"with identifier", ^{
    let(attrs, ^id{ return @{@"cell": @"customId:CustomCell"}; });
    it(@"registers the custom class and custom identifier", ^{
      [[[subject identifiers] should] equal:@{@"customId": [CustomCell class]}];
    });
  });
});

context(@"with multiple cells", ^{
  let(attrs, ^id{ return @{@"cell": @"CustomCell|anotherId:UICollectionViewCell"}; });
  it(@"registers the custom classes and custom identifiers", ^{
    [[[subject identifiers] should] equal:@{@"CustomCell": [CustomCell class], @"anotherId": [UICollectionViewCell class]}];
  });
});

SPEC_END