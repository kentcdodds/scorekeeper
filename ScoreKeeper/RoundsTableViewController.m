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
#import "SetupTableViewController.h"
#import "TeamScores.h"

@interface RoundsTableViewController () <AddScoreDelegate>

@end

@implementation RoundsTableViewController

- (IBAction)cancelModal:(UIStoryboardSegue *)segue {
    // Ignore
}

- (void)setScore:(NSArray *)scores {
    [self.teamScores addScores:scores];
    [self.tableView reloadData];
    [self.delegate reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rounds = [self.teamScores numberOfRounds];
    if (rounds == 0) {
        return 0;
    } else {
        return rounds + 1; // For totals
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoundTableViewCell *cell = (RoundTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"RoundCell" forIndexPath:indexPath];
    BOOL isTotalsCell = indexPath.item == [self.teamScores numberOfRounds];
    NSString *roundLabelText = isTotalsCell ? @"Totals" : [NSString stringWithFormat:@"Round %d", (indexPath.item + 1)];
    
    cell.roundLabel.text = roundLabelText;
    NSMutableArray *scoreStrings = [[NSMutableArray alloc] init];
    NSArray *scores = isTotalsCell ? [self.teamScores totalScores] : [self.teamScores scoresForRound:indexPath.item];
    for (int i = 0; i < [self.teamScores numberOfTeams]; i++) {
        [scoreStrings addObject:[NSString stringWithFormat:@"%@: %@", self.teamScores.teamNames[i], scores[i]]];
    }
    cell.scoresLabel.text = [scoreStrings componentsJoinedByString:@"\n"];
    
    return cell;
}


@end
