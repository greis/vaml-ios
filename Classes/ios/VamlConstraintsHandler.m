#import "VamlConstraintsHandler.h"
#import "Vaml.h"
#import <ConstraintFormatter/ConstraintFormatter.h>

@interface VamlConstraintsHandler ()
@property(nonatomic) UIView* rootView;
@property(nonatomic) NSMutableArray *formats;
@property(nonatomic) NSMutableDictionary *viewsDict;
@property(nonatomic) BOOL useSuperviewAsRoot;
@end


@implementation VamlConstraintsHandler

+(void)addConstraintsTo:(UIView *)view {
  VamlConstraintsHandler *handler = [[self alloc] initWithRootView:view];
  [handler apply];
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

-(void)apply {
  [self populateFormatsForView:self.rootView];
  UIView *targetView = self.useSuperviewAsRoot ? self.rootView.superview : self.rootView;
  [targetView addConstraintsWithFormats:self.formats views:self.viewsDict metrics:nil];
}

-(void)populateFormatsForView:(UIView *)view {
  NSDictionary *attrs = view.vamlData.attrs;
  [attrs enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL *stop) {
    if ([self isValidAttribute:key]) {
      if ([value rangeOfString:@"parent"].location != NSNotFound) {
        
        if (view == self.rootView) {
          self.useSuperviewAsRoot = YES;
        }
        
        [self addView:view.superview];
        value = [value stringByReplacingOccurrencesOfString:@"parent" withString:[self viewId:view.superview]];
      }
      [self addView:view];
      
      value = [value stringByReplacingOccurrencesOfString:self.rootView.vamlId withString:[self viewId:self.rootView]];
      
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
  if (view != self.rootView || (self.useSuperviewAsRoot && self.rootView.superview != nil)) {
    [self.viewsDict setObject:view forKey:view.vamlId];
  }
}

-(NSString *)viewId:(UIView *)view {
  if (self.useSuperviewAsRoot) {
    if (view == self.rootView.superview) {
      return @"superview";
    } else {
      return view.vamlId;
    }
    
  } else {
   return view == self.rootView ? @"superview" : view.vamlId;
  }
}

@end
