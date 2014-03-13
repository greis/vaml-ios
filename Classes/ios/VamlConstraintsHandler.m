#import "VamlConstraintsHandler.h"
#import "UIView+Vaml.h"
#import <ConstraintFormatter/ConstraintFormatter.h>

@implementation VamlConstraintsHandler

+(void)addConstraintsTo:(UIView *)rootView {
  NSMutableArray *formats = [NSMutableArray array];
  
  id validAttrs = @[@"center",
                    @"edges",
                    @"size",
                    @"left",
                    @"right",
                    @"top",
                    @"bottom",
                    @"width",
                    @"height",
                    @"centerX",
                    @"centerY",
                    @"baseline",
                    @"leading",
                    @"trailing"
                    ];
  
  NSMutableDictionary *views = [NSMutableDictionary dictionary];
  [self populate:views withParentView:rootView];
  
  [views enumerateKeysAndObjectsUsingBlock:^(NSString *viewId, UIView *view, BOOL *stop) {
    NSDictionary *attrs = view.vamlAttrs;
    [attrs enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
      if ([validAttrs containsObject:key]) {
        if ([value isEqualToString:@"parent"]) {
          value = [NSString stringWithFormat:@"%@.%@", view.superview.vamlId, key];
        }
        NSString *constraint = [NSString stringWithFormat:@"%@.%@ == %@", view.vamlId, key, value];
        [formats addObject:constraint];
      }
    }];
  }];
  
  [rootView addConstraintsWithFormats:formats views:views metrics:nil];
}

+(void)populate:(NSMutableDictionary *)views withParentView:(UIView *)rootView {
  [views setObject:rootView forKey:rootView.vamlId];
  for (UIView *subview in rootView.subviews) {
    [self populate:views withParentView:subview];
  }
}

@end
