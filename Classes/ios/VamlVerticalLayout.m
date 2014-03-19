#import "VamlVerticalLayout.h"

@implementation VamlVerticalLayout

-(NSLayoutAttribute)alignmentAttribute {
  return NSLayoutAttributeCenterX;
}

-(NSLayoutAttribute)dimensionAttribute {
  return NSLayoutAttributeWidth;
}

-(NSString *)orientationForVisualFormat {
  return @"V";
}

@end
