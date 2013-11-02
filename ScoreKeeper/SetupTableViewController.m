//
//  SetupTableViewController.m
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "SetupTableViewController.h"
#import "TeamScores.h"
#import "RoundsTableViewController.h"

#define TEAM_NAMES_SECTION_INDEX      1

@interface SetupTableViewController () <UITextFieldDelegate>

@property(strong, nonatomic) TeamScores *teamScores;

@end

@implementation SetupTableViewController

- (TeamScores *)teamScores {
    if (!_teamScores) {
        _teamScores = [[TeamScores alloc] init];
    }
    return _teamScores;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[RoundsTableViewController class]]) {
        RoundsTableViewController *roundsVC = (RoundsTableViewController *)segue.destinationViewController;
        roundsVC.teamScores = self.teamScores;
        // Now you can access properties and methods on roundsVC.
        // You may also want to test the segue.identifier if you have two
        // segues to the same destination VC, like in my storyboard example.
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == TEAM_NAMES_SECTION_INDEX) {
        return 4;
    }
    return 1;
}

# pragma mark - text field delegation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.teamScores setName:textField.text forTeam:textField.tag];
}

@end
