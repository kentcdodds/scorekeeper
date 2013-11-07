//
//  RoundTableViewCell.h
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;

@end
