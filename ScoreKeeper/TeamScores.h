//
//  TeamScores.h
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#define MAX_TEAM_COUNT 4
#define MIN_TEAM_COUNT 2

@interface TeamScores : NSObject

@property (nonatomic) NSUInteger numberOfTeams;
@property (strong, nonatomic) NSArray *teamNames;

- (void)addScores:(NSArray *)scores;
- (void)clearScores;
- (NSUInteger)numberOfRounds;
- (NSArray *)scoresForRound:(NSUInteger)round;
- (void)setName:(NSString *)teamName forTeam:(NSUInteger)teamIndex;
- (NSArray *)totalScores;

@end