//
//  TeamScores.m
//  ScoreKeeper
//
//  Created by Kent C. Dodds on 11/2/13.
//  Copyright (c) 2013 Kent C. Dodds. All rights reserved.
//

#include "TeamScores.h"

@interface TeamScores()
@property (strong, nonatomic) NSArray *rounds; // Of NSArray of NSNumber
@end

@implementation TeamScores

#pragma mark - Initialization

- (id)init {
    self = [super init];
    
    if (self) {
        [self setNumberOfTeams: MIN_TEAM_COUNT];
    }
    
    return self;
}

#pragma mark - Getters and setters

- (NSArray *)teamNames {
    if (!_teamNames) {
        _teamNames = [[NSArray alloc] init];
    }
    return _teamNames;
}

- (NSArray *)rounds {
    if (!_rounds) {
        _rounds = [[NSArray alloc] init];
    }
    return _rounds;
}

- (void)setNumberOfTeams:(NSUInteger)numberOfTeams {
    if (numberOfTeams > MAX_TEAM_COUNT || numberOfTeams < MIN_TEAM_COUNT) {
        return;
    }

    NSMutableArray *names = [[NSMutableArray alloc] initWithCapacity:numberOfTeams];
    
    for (NSUInteger i = 0; i < numberOfTeams; i++) {
        if (i < self.teamNames.count) {
            names[i] = self.teamNames[i];
        } else {
            names[i] = [NSString stringWithFormat:@"Team %u", i + 1];
        }
    }
    
    self.teamNames = [names copy];
    _numberOfTeams = [self.teamNames count];

    if ([self.rounds count] > 0) {
        NSMutableArray *mutableRounds = [[NSMutableArray alloc] initWithCapacity:[self.rounds count]];
        
        for (NSUInteger i = 0; i < [self.rounds count]; i++) {
            NSArray *scores = self.rounds[i];
            NSMutableArray *mutableScores = [[NSMutableArray alloc] initWithCapacity:numberOfTeams];
            
            for (NSUInteger j = 0; j < numberOfTeams; j++) {
                if (j < [scores count]) {
                    mutableScores[j] = scores[j];
                } else {
                    mutableScores[j] = @(0);
                }
            }
            
            mutableRounds[i] = [mutableScores copy];
        }
        
        self.rounds = [mutableRounds copy];
    }
}

#pragma mark - Helpers

- (void)addScores:(NSArray *)scores {
    NSMutableArray *mutableRounds = [[NSMutableArray alloc] initWithArray:self.rounds];
    [mutableRounds addObject:scores];
    self.rounds = [[NSArray alloc] initWithArray:mutableRounds];
}

- (void)setName:(NSString *)teamName forTeam:(NSUInteger)teamIndex {
    if (teamIndex > [self numberOfTeams]) {
        return;
    }
    if (!teamName) {
        teamName = [NSString stringWithFormat:@"%d", teamIndex + 1];
    }
    teamName = [teamName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSMutableArray *mutableTeamNames = [[NSMutableArray alloc] initWithArray:self.teamNames];
    mutableTeamNames[teamIndex] = teamName;
    self.teamNames = [mutableTeamNames copy];
}

- (void)clearScores {
    self.rounds = [[NSArray alloc] init];
}

- (NSUInteger)numberOfRounds {
    return [self.rounds count];
}

- (NSArray *)scoresForRound:(NSUInteger)round {
    if (round >= [self.rounds count]) {
        return nil;
    }
    return self.rounds[round];
}

- (NSArray *)totalScores {
    int totals[self.numberOfTeams];
    for (int i = 0; i < self.numberOfTeams; i++) {
        totals[i] = 0;
    }
    for (NSArray *scores in self.rounds) {
        for (int i = 0; i < [scores count]; i++) {
            totals[i] += [scores[i] integerValue];
        }
    }
    NSMutableArray *totalsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.numberOfTeams; i++) {
        [totalsArray addObject:[NSNumber numberWithInt:totals[i]]];
    }
    return [totalsArray copy];
}

@end