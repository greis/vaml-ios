#import "VamlHorizontalLayout.h"
#import "UIView+Vaml.h"

@implementation VamlHorizontalLayout

-(void)didAddAllSubviews {
  NSMutableDictionary *subviews = [NSMutableDictionary dictionary];
  NSMutableArray *subviewsName = [NSMutableArray array];
  
  int padding = [self padding];
  
  for (UIView *view in self.subviews) {
    [subviewsName addObject:view.vamlId];
    subviews[view.vamlId] = view;
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:view
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1
                         constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:view
                         attribute:NSLayoutAttributeHeight
                         multiplier:1
                         constant:2 * padding]];
  }
  
  NSString *format = [NSString stringWithFormat:@"H:|-padding-[%@]-padding-|", [subviewsName componentsJoinedByString:@"]-padding-["]];
  id metrics = @{@"padding": @(padding)};
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:subviews]];
}

-(int)padding {
  NSNumber *padding = self.vamlAttrs[@"padding"];
  return padding ? [padding integerValue] : 0;
}

@end
