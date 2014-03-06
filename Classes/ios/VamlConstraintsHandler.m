#import "VamlConstraintsHandler.h"
#import "UIView+Vaml.h"
#import <ConstraintFormatter/ConstraintFormatter.h>

@implementation VamlConstraintsHandler

+(void)addConstraintsTo:(UIView *)rootView context:(VamlContext *)context {
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
  
  [context.views enumerateKeysAndObjectsUsingBlock:^(NSString *viewId, UIView *view, BOOL *stop) {
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
  
  [rootView addConstraintsWithFormats:formats views:context.views metrics:nil];
}

@end
