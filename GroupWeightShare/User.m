//
//  User.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//

#import "User.h"

@implementation User

@synthesize isMale=_isMale;
@synthesize birthYear=_birthYear;
@synthesize isShared=_isShared;

- (id)init
{
    if ((self = [super init])) {
        self.isMale = NO;
        self.birthYear = 0;
        self.isShared = YES;
    }
    return self;
}
@end
