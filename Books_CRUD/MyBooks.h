//
//  MyBooks.h
//  Assignment4
//
//  Created by  on 11/23/14.
//  Copyright (c) 2014 Ankur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyBooks : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * libName;
@property (nonatomic, retain) NSDate * dueDate;

@end
