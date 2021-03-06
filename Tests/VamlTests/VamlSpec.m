#import "Kiwi.h"
#import "Vaml.h"
#import <UIKit/UIKit.h>
#import "VamlVerticalLayout.h"
#import "VamlHorizontalLayout.h"
#import "CustomView.h"
#import "CustomViewFromVaml.h"

SPEC_BEGIN(VamlSpec)

describe(@"#applyVaml", ^{
  
  specify(^{
    UIViewController *controller = [[UIViewController alloc] init];
    [controller applyVamlLayout:@"example" locals:@{@"message": @"ABC"}];
    UIView *rootView = [controller view];
    
    [[rootView.subviews should] haveCountOf:2];
    
    [[[rootView.subviews[0] class] should] equal:[VamlVerticalLayout class]];
    [[[rootView.subviews[1] class] should] equal:[UILabel class]];
    
    VamlVerticalLayout *layout = rootView.subviews[0];
    [[layout.subviews should] haveCountOf:6];
    
    [[[layout.subviews[0] class] should] equal:[VamlHorizontalLayout class]];
    [[[layout.subviews[1] class] should] equal:[CustomView class]];
    [[[layout.subviews[2] class] should] equal:[CustomViewFromVaml class]];
    [[[layout.subviews[3] class] should] equal:[UITableView class]];
    [[[layout.subviews[4] class] should] equal:[UICollectionView class]];
    [[[layout.subviews[5] class] should] equal:[UIScrollView class]];
    
    VamlHorizontalLayout *horizontLayout = layout.subviews[0];
    [[horizontLayout.subviews should] haveCountOf:3];
    
    UIButton *buttonWithEvent = horizontLayout.subviews[0];
    [[buttonWithEvent.allTargets should] haveCountOf:1];
    [[theValue([buttonWithEvent.allTargets containsObject:controller]) should] beTrue];
    
    CustomViewFromVaml *customView = layout.subviews[2];
    [[customView.subviews should] haveCountOf:1];
    [[[customView.subviews[0] class] should] equal:[VamlHorizontalLayout class]];
    VamlHorizontalLayout *horizontal = customView.subviews[0];
    
    [[horizontal.subviews should] haveCountOf:2];
    [[[horizontal.subviews[0] class] should] equal:[UILabel class]];
    [[[horizontal.subviews[1] class] should] equal:[UILabel class]];
    
    UITableView *table = layout.subviews[3];
    id tableDelegate = table.delegate;
    [[tableDelegate should] equal:controller];
    id tableDatasource = table.dataSource;
    [[tableDatasource should] equal:controller];
    
    UIScrollView *scroll = layout.subviews[5];
    [[scroll.subviews should] haveCountOf:1];
    [[[scroll.subviews[0] class] should] equal:[UIImageView class]];
    
    UILabel *label = rootView.subviews[1];
    [[label.text should] equal:@"ABC"];
  });
});

SPEC_END