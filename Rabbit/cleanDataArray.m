//
//  cleanDataArray.m
//  Rabbit
//
//  Created by andrew hazlett on 3/2/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "cleanDataArray.h"

@implementation cleanDataArray

-(NSArray*)cleanArray :(NSArray*)nameAry width:(NSArray*)widthAry height:(NSArray*)heightAry{
    NSMutableArray *clear = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < nameAry.count; i++) {
        [clear addObject:nameAry[i]];
        [clear addObject:widthAry[i]];
        [clear addObject:heightAry[i]];
    }
    
    return clear;
}

@end
