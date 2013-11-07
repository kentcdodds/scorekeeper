//
//  AddScoreTableViewController.h
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamScores.h"

@protocol AddScoreDelegate;

@interface AddScoreTableViewController : UITableViewController

@property(strong, nonatomic) TeamScores *teamScores;
@property (weak, nonatomic) id <AddScoreDelegate> delegate;

@end

@protocol AddScoreDelegate <NSObject>

- (void)setScore:(NSArray *)scores;

@end