//
//  DataArray.m
//  Rabbit
//
//  Created by andrew hazlett on 3/9/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//

#import "DataArray.h"

@implementation DataArray

@synthesize myData,myTable,nameColom,hightColom,widthColom;

-(NSArray*)getDictionaryKeyNames{
    return [myData  allKeys];
}

-(NSArray*)getRowData:(NSString*)rowName{
    return [myData valueForKey:rowName];
}

-(NSString*) getNameAtIndex:(NSInteger)row{
    return [nameColom objectAtIndex:row];
}

-(NSString*) getWidthAtIndex:(NSInteger)row{
    return [widthColom objectAtIndex:row];
}

-(NSString*) getHeightAtIndex:(NSInteger)row{
    return [hightColom objectAtIndex:row];
}

-(NSMutableArray*) replaceSubArray:(NSMutableArray*)subArray atIndex:(int)index setStrValue:(NSString*)value valueForKey:(NSString*)valueKey{
    if (index < [subArray count]) {
        NSMutableArray *myRowData = [[NSMutableArray alloc] initWithArray:subArray];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] initWithDictionary:[myRowData objectAtIndex:index]];
        [dic setValue:value forKey:valueKey];
        [myRowData replaceObjectAtIndex:index withObject:dic];
        
        return myRowData;
    }
    return nil;
}

-(NSMutableArray*) replaceSubArray:(NSMutableArray*)subArray atIndex:(int)index setNumberValue:(float)value valueForKey:(NSString*)valueKey{
    if (index < [subArray count]) {
        NSMutableArray *myRowData = [[NSMutableArray alloc] initWithArray:subArray];
        NSMutableDictionary *dic =[[NSMutableDictionary alloc] initWithDictionary:[myRowData objectAtIndex:index]];
        [dic setValue:[NSNumber numberWithFloat:value] forKey:valueKey];
        [myRowData replaceObjectAtIndex:index withObject:dic];
        
        return myRowData;
    }
    return nil;
}

-(NSMutableDictionary*)newData:(NSString*)title{
    NSMutableArray *ourRowData = [[NSMutableArray alloc]initWithObjects:[self newTableData], nil];
    NSMutableDictionary *usrData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:ourRowData,title,nil ];
    return usrData;
}

-(NSMutableDictionary*)newTableData{
    NSMutableDictionary *myColomData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Icon",@"Name",@"40",@"Width",@"40",@"Height", nil];
    return myColomData;
}

-(NSArray*)cleanArray :(NSArray*)nameAry width:(NSArray*)widthAry height:(NSArray*)heightAry{
    NSMutableArray *clear = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < nameAry.count; i++) {
        [clear addObject:nameAry[i]];
        [clear addObject:widthAry[i]];
        [clear addObject:heightAry[i]];
    }
    return clear;
}

-(NSMutableArray*)createNewData{
    NSMutableDictionary *dicAry = [[NSMutableDictionary alloc] initWithDictionary:[self newTableData]];
    NSMutableArray *ourRowData = [[NSMutableArray alloc]init];
    [ourRowData addObject:dicAry];
    for (NSInteger i = 0; i < [nameColom count]; i++) {
        [dicAry setObject:[nameColom objectAtIndex:i] forKey:@"Name"];
        [dicAry setObject:[widthColom objectAtIndex:i] forKey:@"Width"];
        [dicAry setObject:[hightColom objectAtIndex:i] forKey:@"Height"];
        [ourRowData addObject:[dicAry copy]];
    }
  //  NSLog(@"new data:%@",ourRowData);
    return ourRowData;
}

-(void)createTableData{
    NSMutableDictionary *dicAry = [[NSMutableDictionary alloc] initWithDictionary:myData];

    for (NSInteger i = 0; i < [nameColom count]; i++) {
        [dicAry setObject:[nameColom objectAtIndex:i] forKey:@"Name"];
        [dicAry setObject:[widthColom objectAtIndex:i] forKey:@"Width"];
        [dicAry setObject:[hightColom objectAtIndex:i] forKey:@"Height"];
    }
      NSLog(@"createTableData:%@ - %@",myData,dicAry);
}
@end