#import "ExampleController.h"
#import <vaml/Vaml.h>

@interface ExampleController ()

@end

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  [Vaml layout:@"example" view:self.view];
}

@end
