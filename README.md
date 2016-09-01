###Example

<image src="https://media.giphy.com/media/26ybvMEsUFnwMGzmM/giphy.gif" />

###ExampleController.m

```obj-c
#import <vaml/Vaml.h>

@implementation ExampleController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.view.layer setBorderColor:[UIColor redColor].CGColor];
  [self.view.layer setBorderWidth:1.];
  
  [self applyVamlLayout:@"example" locals:@{@"message": @"ABC"}];
  UIButton *okButton = (UIButton *)[self findViewById:@"ok_button"];
  assert(okButton != nil);
  [okButton addTarget:self action:@selector(didTapOk:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didTapOk:(UIButton *)button {
  button.hidden = YES;
  UIView *buttons = [self findViewById:@"buttons"];
  [buttons setNeedsUpdateConstraints];
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

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
  [cell setBackgroundColor:indexPath.row % 2 == 0 ? [UIColor lightGrayColor] : [UIColor purpleColor]];
  return cell;
}
```

###example.vaml

```haml
%root#root
  %vertical#input_group(centerX="parent.centerX - 20" centerY="root" padding="10" itemsSpacing="5" itemsAlignment="left")
    %horizontal#buttons(hiddenItems="false")
      %button#username_input(onClick="didTapUsername")
      %button#ok_button
      %button(title="hidden" hidden="true" width="300")
    %view(type="CustomView")
    %view(type="CustomViewFromVaml" message1="Hello" message2="World")
    %table(width="parent.width - 20" height="40")
    %collection(width="parent.width - 20" height="70" scrollDirection="horizontal")
    %scroll(width="100" height="40")
      %image(name="image" edges="parent")
  %label(text="#{message}" left="input_group.right" baseline="input_group.top")
```


###How to contribute

You need cocoapods to be installed. And then:

```
cd Tests
pod install
open Vaml.xcworkspace
```

To run the tests, just command+u or go to menu Product -> Test.

To run the example app just command+r or Product -> Run.

To edit the library files just open the Project Navigator  and edit the files under Pods -> Development Pods -> vaml
