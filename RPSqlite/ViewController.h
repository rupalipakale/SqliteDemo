//
//  ViewController.h
//  RPSqlite
//
//  Created by Student P_07 on 27/02/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtaddress;
@property (strong, nonatomic) IBOutlet UITextField *txtName;

@property (strong, nonatomic) IBOutlet UITextField *txtid;
- (IBAction)btnActionsave:(id)sender;
- (IBAction)btnActionList:(id)sender;

@end

