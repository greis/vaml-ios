#import "VamlHorizontalLayout.h"

@implementation VamlHorizontalLayout

-(NSLayoutAttribute)alignmentAttribute {
  return NSLayoutAttributeCenterY;
}

-(NSLayoutAttribute)dimensionAttribute {
  return NSLayoutAttributeHeight;
}

-(NSString *)orientationForVisualFormat {
  return @"H";
}

@end
