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
    [controller applyVamlLayout:@"example"];
    UIView *rootView = [controller view];
    
    [[rootView.subviews should] haveCountOf:2];
    
    [[[rootView.subviews[0] class] should] equal:[VamlVerticalLayout class]];
    [[[rootView.subviews[1] class] should] equal:[UILabel class]];
    
    VamlVerticalLayout *layout = rootView.subviews[0];
    [[layout.subviews should] haveCountOf:4];
    
    [[[layout.subviews[0] class] should] equal:[UIButton class]];
    [[[layout.subviews[1] class] should] equal:[UIButton class]];
    [[[layout.subviews[2] class] should] equal:[CustomView class]];
    [[[layout.subviews[3] class] should] equal:[CustomViewFromVaml class]];
    
    UIButton *buttonWithEvent = layout.subviews[0];
    [[buttonWithEvent.allTargets should] haveCountOf:1];
    [[theValue([buttonWithEvent.allTargets containsObject:controller]) should] beTrue];
    
    CustomViewFromVaml *customView = [[CustomViewFromVaml alloc] init];
    [[customView.subviews should] haveCountOf:1];
    [[[customView.subviews[0] class] should] equal:[VamlHorizontalLayout class]];
    VamlHorizontalLayout *horizontal = customView.subviews[0];
    
    [[horizontal.subviews should] haveCountOf:2];
    [[[horizontal.subviews[0] class] should] equal:[UILabel class]];
    [[[horizontal.subviews[1] class] should] equal:[UILabel class]];
    
  });
  
});

SPEC_END