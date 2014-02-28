#import "ExampleController.h"
#import <vaml/Vaml.h>

@interface ExampleController ()

@end

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  [Vaml layout:@"example" view:self.view];
  [self.view.subviews[0] setCenter:self.view.center];
}

@end
