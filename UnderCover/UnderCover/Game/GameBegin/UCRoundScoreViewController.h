//
//  UCRoundScoreViewController.h
//  UnderCover
//
//  Created by Wayde Sun on 7/21/13.
//  Copyright (c) 2013 iHakula. All rights reserved.
//

#import "JBaseViewController.h"

@interface UCRoundScoreViewController : JBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *usersArr;
@property (retain, nonatomic) id delegate;
@end
