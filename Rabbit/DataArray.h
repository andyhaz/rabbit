//
//  DataArray.h
//  Rabbit
//
//  Created by andrew hazlett on 3/9/16.
//  Copyright © 2016 andrew hazlett. All rights reserved.
//
/*
    - titleProfile (use key dictanary arrya)
        - name (array)
        - Width (array)
        - Height (array)
*/
#import <Foundation/Foundation.h>

@interface DataArray : NSObject

@property (nonatomic) NSMutableDictionary *myData;
@property (nonatomic) NSMutableDictionary *myTable;

@property (nonatomic) NSMutableArray *nameColom;
@property (nonatomic) NSMutableArray *hightColom;
@property (nonatomic) NSMutableArray *widthColom;

-(NSArray*)cleanArray :(NSArray*)nameAry width:(NSArray*)widthAry height:(NSArray*)heightAry;

-(NSArray*) getDictionaryKeyNames;
-(NSArray*) getRowData:(NSString*)rowName;

-(NSString*) getNameAtIndex:(NSInteger)row;
-(NSString*) getWidthAtIndex:(NSInteger)row;
-(NSString*) getHeightAtIndex:(NSInteger)row;

-(NSMutableArray*) replaceSubArray:(NSMutableArray*)subArray atIndex:(int)index setStrValue:(NSString*)value valueForKey:(NSString*)valueKey;
-(NSMutableArray*) replaceSubArray:(NSMutableArray*)subArray atIndex:(int)index setNumberValue:(float)value valueForKey:(NSString*)valueKey;

-(NSMutableDictionary*)newData:(NSString*)title;
-(NSMutableDictionary*)newTableData;

-(NSMutableArray*)createNewData;
-(void)createTableData;
@end
