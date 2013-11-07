//
//  RoundsTableViewController.m
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "RoundsTableViewController.h"
#import "RoundTableViewCell.h"
#import "AddScoreTableViewController.h"
#import "TeamScores.h"

@interface RoundsTableViewController () <AddScoreDelegate>

@end

@implementation RoundsTableViewController

- (IBAction)cancelModal:(UIStoryboardSegue *)segue {
//    NSLog(@"Cancel tapped");
}

- (void)setScore:(NSArray *)scores {
    [self.teamScores addScores:scores];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        if ([[navController.viewControllers lastObject] isKindOfClass:[AddScoreTableViewController class]]) {
            AddScoreTableViewController *addScoresVC = (AddScoreTableViewController *)[navController.viewControllers lastObject];
            addScoresVC.teamScores = self.teamScores;
            addScoresVC.delegate = self;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamScores numberOfRounds];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"RoundCell";
    RoundTableViewCell *cell = (RoundTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.roundLabel.text = [NSString stringWithFormat:@"Round %d", (indexPath.item + 1)];
    NSMutableArray *scoreStrings = [[NSMutableArray alloc] init];
    NSArray *scores = [self.teamScores scoresForRound:indexPath.item];
    for (int i = 0; i < [[self.teamScores scoresForRound:indexPath.item] count]; i++) {
        [scoreStrings addObject:[NSString stringWithFormat:@"%@: %@", self.teamScores.teamNames[i], scores[i]]];
    }
    cell.scoresLabel.text = [scoreStrings componentsJoinedByString:@"\n"];
    
    return cell;
}


@end
