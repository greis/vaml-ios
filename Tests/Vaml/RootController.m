#import "RootController.h"
#import "ExampleController.h"

@interface RootController ()

@end

@implementation RootController

- (id)init {
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"open" style:UIBarButtonItemStylePlain target:self action:@selector(didTap:)];
    [self.navigationItem setLeftBarButtonItem:item];
  }
  return self;
}

-(void)didTap:(id)sender {
  ExampleController *controller = [[ExampleController alloc] init];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
