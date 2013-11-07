//
//  AddScoreTableViewController.m
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import "AddScoreTableViewController.h"
#import "RoundsTableViewController.h"


@interface AddScoreTableViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *teamLabels;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *teamScoreFields;
@end

@implementation AddScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UILabel *label in self.teamLabels) {
        if (label.tag < [self.teamScores numberOfTeams]) {
            label.text = self.teamScores.teamNames[label.tag];
        }
    }
}

- (IBAction)saveButtonTouched:(id)sender {
    NSMutableArray *scores = [[NSMutableArray alloc] initWithCapacity:[self.teamScoreFields count]];
    for (UITextField *field in self.teamScoreFields) {
        if (field.tag < [self.teamScores numberOfTeams]) {
            scores[field.tag] = field.text;
        }
    }
    [self.delegate setScore:scores];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.teamScores numberOfTeams];
}

# pragma mark - text field delegation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}


@end
