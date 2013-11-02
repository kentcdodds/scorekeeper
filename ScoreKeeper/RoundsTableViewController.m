//
//  RoundsTableViewController.m
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RoundsTableViewController.h"
#import "AddScoreTableViewController.h"
#import "TeamScores.h"

@interface RoundsTableViewController ()
@end

@implementation RoundsTableViewController

- (IBAction)cancelAdd:(UIStoryboardSegue *)segue {
    // Do nothing.
}

- (IBAction)doneAdding:(UIStoryboardSegue *)segue {
    // Do something
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        if ([[navController.viewControllers lastObject] isKindOfClass:[AddScoreTableViewController class]]) {
            AddScoreTableViewController *addScoresVC = (AddScoreTableViewController *)[navController.viewControllers lastObject];
            addScoresVC.teamScores = self.teamScores;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


@end
