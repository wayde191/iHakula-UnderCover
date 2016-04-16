//
//  UCChoosePlayerViewController.m
//  UnderCover
//
//  Created by Wayde Sun on 7/17/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "UCChoosePlayerViewController.h"
#import "CustomerBarButtonItem.h"
#import "Player.h"
#import "JHomeCell.h"
#import "HomeCellHeader.h"

@interface UCChoosePlayerViewController ()
- (void)leftDoneBtnClicked;
- (void)rightAddBtnClicked;
- (void)hideAddingView;
- (void)addUsers;
- (void)setupNavItems;
- (void)setupUsersData;
- (void)setupSelectedUsers;
@end

@implementation UCChoosePlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ChooseGamePlayer");
        _usersArr = [NSMutableArray array];
        _selectedUserArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavItems];
    [self setupSelectedUsers];
    [self setupUsersData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate & datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JHomeCell *cell = (JHomeCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell toggleCheck];
    
    Player *p = [_usersArr objectAtIndex:indexPath.row];
    if ([cell isChecked]) {
        if (![_selectedUserArr containsObject:p]) {
            [_selectedUserArr addObject:p];
        }
    } else {
        [_selectedUserArr removeObject:p];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeCellHeader *cellHeader = [HomeCellHeader viewFromNib];
    return cellHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _usersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"EmployeeTasksCell";
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[JHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [(JHomeCell *)cell restoreCheck];
    
    Player *p = [_usersArr objectAtIndex:indexPath.row];
    [(JHomeCell *)cell setValues:p];
    
    if ([_selectedUserArr containsObject:p]) {
        [(JHomeCell *)cell toggleCheck];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LOCALIZED_DEFAULT_SYSTEM_TABLE(@"delete");
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Player *p = [_usersArr objectAtIndex:indexPath.row];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"WarmServiceTitle") message:[NSString stringWithFormat:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"SureToDeleteUser"), p.name] selectedBlock:^(NSInteger index){
            if (1 == index) {
                [_selectedUserArr removeObject:p];
                [appDelegate.cdataManager remove:[NSArray arrayWithObject:p]];
                [_usersArr removeObject:p];
                [_tableView reloadData];
            }
        } cancelButtonTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"cancel") otherButtonTitles:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"sure")];
        [alert show];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        if ([textField.text isEqualToString:@""]) {
            [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"InputUserNickname")];
            [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
        } else {
            [self addUsers];
            [self hideAddingView];
        }
    }
    return YES;
}

#pragma mark - Private Methods
- (void)addUsers {
    NSString *seperaterStr = @",";
    if ([CURRENT_LANGUAGE isEqualToString:@"en"]) {
        seperaterStr = @",";
    } else {
        seperaterStr = @"，";
    }
    NSArray *users = [_namesTextField.text componentsSeparatedByString:seperaterStr];
    NSInteger lastPlayerId = [appDelegate.cdataManager getLastPlayerId];
    
    NSMutableArray *players = [NSMutableArray array];
    for (int i = 0; i < users.count; i++) {
        if ([[users objectAtIndex:i] isEqualToString:@""]) {
            continue;
        }
        
        Player *playerInDB = [appDelegate.cdataManager searchObjectByName:[users objectAtIndex:i] withEntityName:@"Player"];
        if (!playerInDB) {
            Player *p = (Player *)[NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:appDelegate.cdataManager.managedObjectContext];
            p.name = [users objectAtIndex:i];
            p.id = [NSNumber numberWithInt:++lastPlayerId];
            p.score = [NSNumber numberWithInt:0];
            p.failure = [NSNumber numberWithInt:0];
            p.victor = [NSNumber numberWithInt:0];
            [players addObject:p];
            
            [_selectedUserArr addObject:p];
        }
    }
    
    if ([appDelegate.cdataManager insert:players]) {
        _namesTextField.text = @"";
        [self setupUsersData];
        [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"AddUserSuccess")];
    } else {
        [self showMessage:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"AddUserFailed")];
    }
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:1.3];
}

- (void)leftDoneBtnClicked {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [self dismissViewControllerAnimated:YES completion:^(){
            if (_delegate && [_delegate respondsToSelector:@selector(onPlayerSelected:)]) {
                [_delegate performSelector:@selector(onPlayerSelected:) withObject:_selectedUserArr];
            }
        }];
    
    
    }else
    {
        if (_delegate&&[_delegate respondsToSelector:@selector(removeChoose)]) {
            [_delegate performSelector:@selector(removeChoose)];
            [_delegate performSelector:@selector(onPlayerSelected:) withObject:_selectedUserArr];
        }
       // [self.navigationController.view removeFromSuperview];
    }
}

- (void)rightAddBtnClicked {
    if (_userAddingView.top == (-1 * _userAddingView.height)) {
        [UIView animateWithDuration:.3 animations:^(){
            _userAddingView.top = 0;
            _tableView.top = _userAddingView.height;
            [self.navigationItem.rightBarButtonItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"ScrollUp")];
            [_namesTextField becomeFirstResponder];
        }];
    } else {
        [self hideAddingView];
    }
}

- (void)hideAddingView {
    [_namesTextField resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^(){
        _userAddingView.top = -1 * _userAddingView.height;
        _tableView.top = 0;
        [self.navigationItem.rightBarButtonItem setTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Add")];
    }];
}

- (void)setupNavItems {
    UIBarButtonItem *leftDoneBtn = [CustomerBarButtonItem createRectBarButtonItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Done")];
    leftDoneBtn.target = self;
    leftDoneBtn.action = @selector(leftDoneBtnClicked);
    self.navigationItem.leftBarButtonItem = leftDoneBtn;
    
    UIBarButtonItem *rightAddBtn = [CustomerBarButtonItem createRectBarButtonItemWithTitle:LOCALIZED_DEFAULT_SYSTEM_TABLE(@"Add")];
    rightAddBtn.target = self;
    rightAddBtn.action = @selector(rightAddBtnClicked);
    self.navigationItem.rightBarButtonItem = rightAddBtn;
}

- (void)setupUsersData {
    NSArray *entities = [appDelegate.cdataManager selectAllObjectsByEntityName:@"Player"];
    if (entities.count) {
        [_usersArr removeAllObjects];
        _usersArr = [NSMutableArray arrayWithArray:entities];
        [_tableView reloadData];
    }
}

- (void)setupSelectedUsers {
    if (_chosePlayersArr.count) {
        _selectedUserArr = [NSMutableArray arrayWithArray:_chosePlayersArr];
    }
}

- (void)viewDidUnload {
    [self setUserAddingView:nil];
    [self setNamesTextField:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
