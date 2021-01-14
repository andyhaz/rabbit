//
//  profileClass.m
//  Rabbit
//
//  Created by andrew hazlett on 3/21/20.
//  Copyright © 2020 andrew hazlett. All rights reserved.
//

#import "profileClass.h"

@implementation profileClass

-(NSArray*)getAlliSize{
    NSArray *iSize = @[[NSNumber numberWithInt:16],
                       [NSNumber numberWithInt:20],
                       [NSNumber numberWithInt:29],
                       [NSNumber numberWithInt:32],
                          [NSNumber numberWithInt:58],
                          [NSNumber numberWithInt:40],
                         [NSNumber numberWithInt:60],
                       [NSNumber numberWithInt:64],
                          [NSNumber numberWithInt:76],
                          [NSNumber numberWithInt:80],
                        [NSNumber numberWithInt:87],
                          [NSNumber numberWithInt:120],
                       [NSNumber numberWithInt:128],
                          [NSNumber numberWithInt:152],
                       [NSNumber numberWithInt:156],
                         [NSNumber numberWithInt:167],
                       [NSNumber numberWithInt:256],
                          [NSNumber numberWithInt:512],
                          [NSNumber numberWithInt:1024]];
 //   NSLog(@"isize%@ is:%lu",iSize,(unsigned long)[iSize count]);
    return iSize;
}

-(int)getiSizeIndex:(NSUInteger)index{
    NSArray *tmpary = [[NSArray alloc] initWithArray:[self getAlliSize]];
    return [[tmpary objectAtIndex:index] intValue];
}


-(NSArray*)listSizeData{
//    NSLog(@"list?");
    NSMutableArray *tempAry = [[NSMutableArray alloc] initWithArray:[self getAlliSize]];
    NSMutableArray *tempHold = [[NSMutableArray alloc]init];
 //   NSLog(@"Temp ary:%@",tempAry);
 //   NSLog(@"temp hold:%ld",(long)num1);
    for (int i=0; i <= [tempAry count]-1; i++) {
   //     NSLog(@"c:%d",i);
        NSString *str = [NSString stringWithFormat:@"%@x%@",[tempAry objectAtIndex:i],[tempAry objectAtIndex:i]];
        [tempHold addObject:str];
     //   NSLog(@"c:%@",tempHold);
    }
  //  NSLog(@"tempHold%@ c:%lu",tempHold,(unsigned long)[tempHold count]);
    return tempHold;
}


-(NSArray*)deviceInfo {
  
    NSMutableArray *dataList = [[NSMutableArray alloc] initWithArray:[self getAlliSize]];
    NSMutableDictionary *md = [[NSMutableDictionary alloc] init];
    NSUInteger aryLength = [dataList count]-1;
            for ( int i = 0; i <= aryLength; i++ ){
                //int screenSize = [dataList indexOfObject:i];
                [md setObject:dataList[i] forKey:@"w"];
                [md setObject:dataList[i] forKey:@"h"];
              //  NSLog(@"B:MD:%@ DL:%@",md,dataList);
                [dataList addObject:md];
               // NSLog(@"MD:%@ DL:%@",md,dataList);
              //  [dataList addObject:iSize[i]];
            }
  // NSLog(@"DL:%@ md:%@",dataList,md);
    
    return dataList;
}
@end
