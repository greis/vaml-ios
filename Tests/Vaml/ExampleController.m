#import "ExampleController.h"
#import <vaml/Vaml.h>

@interface ExampleController ()

@end

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self applyVamlLayout:@"example"];
  
  UIButton *okButton = (UIButton *)[self findViewById:@"ok_button"];
  assert(okButton != nil);
  [okButton addTarget:self action:@selector(didTapOk) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didTapOk {
  NSLog(@"didTapOk");
}

-(void)didTapUsername {
  NSLog(@"didTapUsername");
}

@end
