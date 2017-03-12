//
//  ListViewController.h
//  RPSqlite
//
//  Created by Student P_07 on 03/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tblStudentList;
@property(nonatomic,strong)NSArray *studentList;
@end
