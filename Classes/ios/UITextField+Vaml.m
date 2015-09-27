#import "UITextField+Vaml.h"
#import "VamlData.h"

@implementation UITextField (Vaml)

-(id)initWithVamlData:(VamlData *)data {
  self = [self init];
  [self setPlaceholder:data[@"placeholder"]];
  [self setText:data[@"text"]];
  
  NSString *alignment = data[@"alignment"];
  if ([@"left" isEqualToString:alignment]) {
    [self setTextAlignment:NSTextAlignmentLeft];
  } else if ([@"right" isEqualToString:alignment]) {
    [self setTextAlignment:NSTextAlignmentRight];
  } else if ([@"center" isEqualToString:alignment]) {
    [self setTextAlignment:NSTextAlignmentCenter];
  } else if ([@"justified" isEqualToString:alignment]) {
    [self setTextAlignment:NSTextAlignmentJustified];
  } else if ([@"natural" isEqualToString:alignment]) {
    [self setTextAlignment:NSTextAlignmentNatural];
  }

  return self;
}

@end
