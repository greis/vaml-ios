#import "ExampleController.h"
#import <vaml/Vaml.h>

@interface ExampleController ()

@end

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self applyVamlLayout:@"example"];
  
  UIButton *okButton = (UIButton *)[self findViewById:@"ok_button"];
  [okButton addTarget:self action:@selector(didTapOk) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didTapOk {
  NSLog(@"didTapOk");
}

@end
