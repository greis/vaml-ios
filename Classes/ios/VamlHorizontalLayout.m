//
//  HorizontalLayout.m
//  HamlViews
//
//  Created by Gabriel Reis on 2/21/14.
//  Copyright (c) 2014 Gabriel Reis. All rights reserved.
//

#import "VamlHorizontalLayout.h"
#import "UIView+Vaml.h"

@implementation VamlHorizontalLayout

-(void)didAddAllSubviews {
  [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  NSMutableDictionary *views = [NSMutableDictionary dictionary];
  NSMutableArray *subviewsName = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    [subviewsName addObject:view.vamlId];
    views[view.vamlId] = view;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1 constant:10];
    constraint.priority = UILayoutPriorityRequired;
    [self addConstraint:constraint];
  }
  
  NSString *format = [NSString stringWithFormat:@"H:|-10-[%@]-10-|", [subviewsName componentsJoinedByString:@"]-10-["]];
  id constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
  [self addConstraints:constraints];
}




@end
