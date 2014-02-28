#import "VamlVerticalLayout.h"
#import <PixateFreestyle/PixateFreestyle.h>

@interface VamlVerticalLayout ()

@property(nonatomic, strong) NSDictionary *data;

@end

@implementation VamlVerticalLayout

- (id)initWithData:(NSDictionary *)data {
  self = [super init];
  if (self) {
    [self setData:data];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
  }
  return self;
}

-(void)didAddAllSubviews {
  NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:0];
  constraint.priority = UILayoutPriorityDefaultLow;
  [self addConstraint:constraint];
  
  NSMutableDictionary *views = [NSMutableDictionary dictionary];
  NSMutableArray *subviewsName = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    [subviewsName addObject:view.styleId];
    views[view.styleId] = view;
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
