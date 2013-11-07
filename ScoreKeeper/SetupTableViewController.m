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
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *teamNameFields;

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
    }
}
- (IBAction)changeNumberOfTeams:(UISegmentedControl *)sender {
    int teams = sender.selectedSegmentIndex + 2;
    [self.teamScores setNumberOfTeams:teams];
    for (UITextField *field in self.teamNameFields) {
        if (field.tag < [self.teamScores.teamNames count]) {
            field.text = self.teamScores.teamNames[field.tag];
        }
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == TEAM_NAMES_SECTION_INDEX) {
        return self.teamScores.numberOfTeams;
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
