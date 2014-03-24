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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  [cell setBackgroundColor:indexPath.row % 2 == 0 ? [UIColor lightGrayColor] : [UIColor purpleColor]];
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 10;
}

@end
