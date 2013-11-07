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
#define CLEAR_SCORE_TAG               10
#define CLEAR_DATA_ALERTVIEW_TAG      25
#define CLEAR_DATA_SECTION            3

@interface SetupTableViewController () <UITextFieldDelegate, UIAlertViewDelegate, SetupViewDelegate>
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *teamNameFields;
@property (weak, nonatomic) IBOutlet UISegmentedControl *numberOfTeamsSegmentedControl;

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
        roundsVC.delegate = self;
    }
}

- (void) reloadData {
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == CLEAR_DATA_SECTION) {
        [self showClearGameAlertView];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showClearGameAlertView {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"You Sure?"
                                                            message:@"Are you sure you want to clear all scores?" delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Yes", nil];
        alertView.tag = CLEAR_DATA_ALERTVIEW_TAG;
        [alertView show];
        return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == CLEAR_DATA_ALERTVIEW_TAG) {
        if (buttonIndex == 1) {
            self.teamScores = nil;
            self.numberOfTeamsSegmentedControl.selectedSegmentIndex = 0;
            [self.tableView reloadData];
        }
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
    if ([self.teamScores numberOfRounds] < 1) {
        return 3;
    } else {
        return 4;
    }
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
