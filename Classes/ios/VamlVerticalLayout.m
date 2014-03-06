#import "VamlVerticalLayout.h"
#import <PixateFreestyle/PixateFreestyle.h>
#import "UIView+Vaml.h"

@implementation VamlVerticalLayout

-(void)didAddAllSubviews {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  NSMutableDictionary *views = [NSMutableDictionary dictionary];
  NSMutableArray *subviewsName = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    [subviewsName addObject:view.vamlId];
    views[view.vamlId] = view;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1 constant:10];
    constraint.priority = UILayoutPriorityRequired;
    [self addConstraint:constraint];
  }
  
  NSString *format = [NSString stringWithFormat:@"V:|-10-[%@]-10-|", [subviewsName componentsJoinedByString:@"]-10-["]];
  id constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
  [self addConstraints:constraints];
}




@end
