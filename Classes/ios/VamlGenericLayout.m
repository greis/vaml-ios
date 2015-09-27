#import "VamlGenericLayout.h"
#import "Vaml.h"

@interface VamlGenericLayout ()
@property(nonatomic) NSMutableArray *appliedConstraints;
@end

@implementation VamlGenericLayout

-(void)didLoadFromVaml {
  if (self.subviews.count == 0) { return; }
  [self updateConstraints];
}

-(NSMutableArray *)appliedConstraints {
  if (!_appliedConstraints) {
    _appliedConstraints = [NSMutableArray array];
  }
  return _appliedConstraints;
}

-(void)updateConstraints {
  [self removeConstraints:self.appliedConstraints];
  [self.appliedConstraints removeAllObjects];
  
  if (self.subviews.count > 0) {
    NSMutableDictionary *subviews = [NSMutableDictionary dictionary];
    NSMutableArray *subviewsName = [NSMutableArray array];
    
    BOOL showHiddenChild = [@"true" isEqualToString:self.vamlData[@"hiddenItems"]];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    for (UIView *view in self.subviews) {
      if (!showHiddenChild && view.hidden) { continue; }
      [subviewsName addObject:view.vamlId];
      subviews[view.vamlId] = view;
      [view setTranslatesAutoresizingMaskIntoConstraints:NO];
      NSLayoutConstraint *c = [NSLayoutConstraint
                                                   constraintWithItem:view
                                                   attribute:self.alignmentAttribute
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:self
                                                   attribute:self.alignmentAttribute
                                                   multiplier:1
                                                   constant:self.alignmentPadding];
      c.priority = UILayoutPriorityRequired;
      [self.appliedConstraints addObject:c];
      [self addConstraint:c];
      NSLayoutConstraint *constraint = [NSLayoutConstraint
                           constraintWithItem:self
                           attribute:self.dimensionAttribute
                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                           toItem:view
                           attribute:self.dimensionAttribute
                           multiplier:1
                           constant:2 * self.padding];
      constraint.priority = UILayoutPriorityDefaultLow;
      [self addConstraint:constraint];
      [self.appliedConstraints addObject:constraint];
    }
    
    NSString *format = [NSString stringWithFormat:@"%@:|-padding-[%@]-padding-|",
                        self.orientationForVisualFormat,
                        [subviewsName componentsJoinedByString:@"]-spacing-["]];
    id metrics = @{@"padding": @(self.padding), @"spacing": @(self.itemsSpacing)};
    NSArray *visualConstraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:subviews];
    [self addConstraints:visualConstraints];
    [self.appliedConstraints addObjectsFromArray:visualConstraints];
  }
  
  [super updateConstraints];
}

-(int)padding {
  NSNumber *padding = self.vamlData[@"padding"];
  return padding ? [padding integerValue] : 0;
}

-(int)itemsSpacing {
  NSNumber *spacing = self.vamlData[@"itemsSpacing"];
  return spacing ? [spacing integerValue] : 0;
}

-(int)alignmentPadding {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                               userInfo:nil];
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
