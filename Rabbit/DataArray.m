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

-(void) updateName:(NSInteger)row newData:(NSString*)strData{
    [nameColom replaceObjectAtIndex:row withObject:strData];
}

-(void) updateWidth:(NSInteger)row newData:(NSString*)strData{
    [widthColom replaceObjectAtIndex:row withObject:strData];
}

-(void) updateHieght:(NSInteger)row newData:(NSString*)strData{
    [hightColom replaceObjectAtIndex:row withObject:strData];
}

-(NSMutableDictionary*)newData:(NSString*)title{

    NSMutableArray *ourRowData = [[NSMutableArray alloc]initWithObjects:[self newTableData], nil];
    
    NSMutableDictionary *usrData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:ourRowData,title,nil ];
    return usrData;
}

-(NSMutableDictionary*)newTableData{
    NSMutableDictionary *myColomData = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Icon Name",@"Name",@"40",@"Width",@"40",@"Height", nil];
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
@end
