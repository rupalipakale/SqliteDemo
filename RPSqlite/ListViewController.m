//
//  ListViewController.m
//  RPSqlite
//
//  Created by Student P_07 on 03/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ListViewController.h"
#import "DBManager.h"
#import "studentTableViewCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",[[DBManager getInstance] FetchFromDB]);
    _studentList=[[DBManager getInstance] FetchFromDB];
    if(_studentList.count>0)
        [_tblStudentList reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _studentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    studentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil)
    {
        cell=[[studentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell loadData:[_studentList objectAtIndex:indexPath.row]];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row);
        
        NSDictionary *objStudentDict =[_studentList objectAtIndex:indexPath.row];
        NSString *studentID=[objStudentDict valueForKey:@"id"];
        if([[DBManager getInstance] deleteWithId:studentID])
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Success" message:@"Record deleted successfully" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            NSMutableArray *array = [[NSMutableArray alloc]init];
            array = [_studentList mutableCopy];
            [array removeObjectAtIndex:indexPath.row];
            _studentList = [array copy];
            [_tblStudentList reloadData];

        }
        else
        {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Fail" message:@"There is some error in deleting record." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
