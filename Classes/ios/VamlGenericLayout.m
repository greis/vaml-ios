#import "VamlGenericLayout.h"
#import "UIView+Vaml.h"

@implementation VamlGenericLayout

-(void)didAddAllSubviews {
  NSMutableDictionary *subviews = [NSMutableDictionary dictionary];
  NSMutableArray *subviewsName = [NSMutableArray array];
  
  for (UIView *view in self.subviews) {
    [subviewsName addObject:view.vamlId];
    subviews[view.vamlId] = view;
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:view
                         attribute:self.alignmentAttribute
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:self.alignmentAttribute
                         multiplier:1
                         constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self
                         attribute:self.dimensionAttribute
                         relatedBy:NSLayoutRelationGreaterThanOrEqual
                         toItem:view
                         attribute:self.dimensionAttribute
                         multiplier:1
                         constant:2 * self.padding]];
  }
  
  NSString *format = [NSString stringWithFormat:@"%@:|-padding-[%@]-padding-|",
                      self.orientationForVisualFormat,
                      [subviewsName componentsJoinedByString:@"]-padding-["]];
  id metrics = @{@"padding": @(self.padding)};
  [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:subviews]];
}

-(int)padding {
  NSNumber *padding = self.vamlAttrs[@"padding"];
  return padding ? [padding integerValue] : 0;
}

-(NSLayoutAttribute)alignmentAttribute {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

-(NSLayoutAttribute)dimensionAttribute {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

-(NSString *)orientationForVisualFormat {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
}

@end
