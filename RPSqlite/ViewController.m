//
//  ViewController.m
//  RPSqlite
//
//  Created by Student P_07 on 27/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"
#import "ListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //NSLog(@"%@",[[DBManager getInstance] FetchFromDB]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnActionsave:(id)sender {
    if ( ![_txtName.text isEqualToString:@""] && ![_txtaddress.text isEqualToString:@""]) {
        if([[DBManager getInstance] insertDataIntoDB:_txtName.text alongwithaddress:_txtaddress.text])
        {
            [self clearText];
            [self ShowAlertwithTitle:@"Success" andMessage:@"Record saved successfully"];
        }
        else
        {
            [self ShowAlertwithTitle:@"Error" andMessage:@"There is some error in saving records...Please try again"];
        }
    }
}

-(void)ShowAlertwithTitle:(NSString *)title andMessage:(NSString *)msg
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self btnActionList:self];
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)btnActionList:(id)sender {
    ListViewController *listVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
    [self.navigationController pushViewController:listVC animated:YES];
}

-(void)clearText
{
    _txtName.text=@"";
    _txtaddress.text=@"";
}
@end
