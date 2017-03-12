//
//  studentTableViewCell.h
//  RPSqlite
//
//  Created by Student P_07 on 03/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface studentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblId;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic)NSDictionary *dictRecord;
- (IBAction)BtnEditClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnEdit;
-(void)loadData:(NSDictionary *)dict;
@property (strong, nonatomic)IBOutlet  UITextField *txtName;
@property (strong, nonatomic)IBOutlet  UITextField *txtAddress;
@end
