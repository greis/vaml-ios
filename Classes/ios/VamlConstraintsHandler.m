#import "VamlConstraintsHandler.h"
#import "UIView+Vaml.h"
#import <ConstraintFormatter/ConstraintFormatter.h>

@interface VamlConstraintsHandler ()
@property(nonatomic) UIView* rootView;
@property(nonatomic) NSMutableArray *formats;
@property(nonatomic) NSMutableDictionary *viewsDict;
@end


@implementation VamlConstraintsHandler

+(void)addConstraintsTo:(UIView *)rootView {
  VamlConstraintsHandler *handler = [[self alloc] initWithRootView:rootView];
  [handler populateFormatsForView:rootView];
  [rootView addConstraintsWithFormats:handler.formats views:handler.viewsDict metrics:nil];
}

#pragma mark - private

-(id)initWithRootView:(UIView *)rootView {
  self = [super init];
  if (self) {
    [self setRootView:rootView];
    [self setFormats:[NSMutableArray array]];
    [self setViewsDict:[NSMutableDictionary dictionary]];
  }
  return self;
}

-(void)populateFormatsForView:(UIView *)view {
  NSDictionary *attrs = view.vamlAttrs;
  [attrs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
    if ([self isValidAttribute:key]) {
      [self addView:view];
      if ([value rangeOfString:@"parent"].location != NSNotFound) {
        [self addView:view.superview];
        value = [value stringByReplacingOccurrencesOfString:@"parent" withString:[self viewId:view.superview]];
      }
      
      value = [value stringByReplacingOccurrencesOfString:self.rootView.vamlId withString:@"superview"];
      
      NSString *constraint = [NSString stringWithFormat:@"%@.%@ == %@", [self viewId:view], key, value];
      [self.formats addObject:constraint];
    }
  }];
  for (UIView *subview in view.subviews) {
    [self populateFormatsForView:subview];
  }
}

-(BOOL)isValidAttribute:(NSString *)attr {
  static NSArray *validAttributes;
  if (!validAttributes) {
    validAttributes = @[@"center",
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
    
  }
  return [validAttributes containsObject:attr];
}

-(void)addView:(UIView *)view {
  if (view != self.rootView) {
    [self.viewsDict setObject:view forKey:view.vamlId];
  }
}

-(NSString *)viewId:(UIView *)view {
  return view == self.rootView ? @"superview" : view.vamlId;
}

@end
