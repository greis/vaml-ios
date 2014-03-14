#import "ExampleController.h"
#import <vaml/Vaml.h>

@interface ExampleController ()

@end

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view.layer setBorderColor:[UIColor redColor].CGColor];
  [self.view.layer setBorderWidth:1.];
  
  [self applyVamlLayout:@"example"];
  UIButton *okButton = (UIButton *)[self findViewById:@"ok_button"];
  assert(okButton != nil);
  [okButton addTarget:self action:@selector(didTapOk) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didTapOk {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Action" message:@"didTapOk" delegate:nil
                                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

-(void)didTapUsername {
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Action" message:@"didTapUsername" delegate:nil
                                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

@end
