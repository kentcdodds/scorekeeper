//
//  RoundsTableViewController.h
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamScores.h"
//#import "AddScoreTableViewController.h"

@interface RoundsTableViewController : UITableViewController

@property(strong, nonatomic) TeamScores *teamScores;

//@property (nonatomic, weak) id<SendScoresProtocol> delegate;

@end
