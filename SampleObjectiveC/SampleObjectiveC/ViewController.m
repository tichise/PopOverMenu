//
//  ViewController.m
//  SampleObjectiveC
//
//  Created by ichise on 2017/07/31.
//

#import "ViewController.h"
@import PopOverMenu;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"menu" style:UIBarButtonItemStylePlain target:self action:@selector(openMenu:)];
    self.navigationItem.rightBarButtonItem = buttonItem;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)openMenu:(id)sender {
    
    NSArray *titles = @[@"Menu1", @"Menu2", @"Menu3"];
    NSArray *descriptions = @[@"description1", @"", @"description3"];
    
    PopOverViewController *popOverViewController = [PopOverViewController instantiate];
    
    [popOverViewController setTitlesWithTitles:titles];
    [popOverViewController setDescriptionsWithDescriptions:descriptions];
    
    popOverViewController.popoverPresentationController.barButtonItem = sender;
    popOverViewController.preferredContentSize = CGSizeMake(300, 135);
    popOverViewController.presentationController.delegate = self;
    
    [popOverViewController setCompletionHandler:^(NSInteger selectRow) {
        switch (selectRow) {
            case 0:
                break;
            case 1:
                break;
            case 2:
                break;
            default:
                break;
        }
    }];
    
    [self presentViewController:popOverViewController animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
