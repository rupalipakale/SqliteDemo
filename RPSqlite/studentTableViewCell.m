//
//  studentTableViewCell.m
//  RPSqlite
//
//  Created by Student P_07 on 03/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "studentTableViewCell.h"

@implementation studentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadData:(NSDictionary *)dict
{
    self.dictRecord=dict;
    self.lblId.text=[NSString stringWithFormat:@"ID = %@",[dict valueForKey:@"id"] ];
    self.lblName.text=[NSString stringWithFormat:@"Name = %@",[dict valueForKey:@"name"]];
    self.lblAddress.text=[NSString stringWithFormat:@"Address = %@",[dict valueForKey:@"address"]];
}

- (IBAction)BtnEditClicked:(id)sender{
    
    if(_btnEdit.tag==0)
    {
        _txtName.hidden=NO;
        _txtAddress.hidden=NO;
        _txtName.backgroundColor=[UIColor whiteColor];
        _txtAddress.backgroundColor=[UIColor whiteColor];
        _txtName.text=[self.dictRecord valueForKey:@"name"];
        _txtAddress.text=[self.dictRecord valueForKey:@"address"];
        _btnEdit.tag=1;
    }
    else
    {
        if([[DBManager getInstance] UpdateWithId:[self.dictRecord valueForKey:@"id"] andName:_txtName.text andAddress:_txtAddress.text])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DataUpdated"
                                                                object:self];
        _txtName.hidden=YES;
        _txtAddress.hidden=YES;
        _btnEdit.tag=0;
        }
        else
        {
           
        }
    }
}

- (UITableView *)relatedTable
{
    if ([self.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview;
    else if ([self.superview.superview isKindOfClass:[UITableView class]])
        return (UITableView *)self.superview.superview;
    else
    {
        NSAssert(NO, @"UITableView shall always be found.");
        return nil;
    }
    
}
@end
