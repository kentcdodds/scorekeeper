//
//  RoundsTableViewController.h
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamScores.h"
@protocol SetupViewDelegate;

@interface RoundsTableViewController : UITableViewController

@property(strong, nonatomic) TeamScores *teamScores;

@property (weak, nonatomic) id <SetupViewDelegate> delegate;

@end

@protocol SetupViewDelegate <NSObject>

- (void)reloadData;

@end