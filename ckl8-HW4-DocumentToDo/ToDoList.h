//
//  PCETodoList.h
//  UWTodoApp
//
//  Created by Martin Nash on 7/8/14.
//  Copyright (c) 2014 Martin Nash (UW). All rights reserved.
//

#import <Foundation/Foundation.h>


@class ToDoList;
@class ToDoItem;

@interface ToDoList : NSObject <NSCoding>

@property (assign) BOOL allowsDuplicates;
@property (copy, nonatomic) NSString *title;

-(instancetype)initWithTitle:(NSString*)title;

// wrapper around array
-(void)addItem:(ToDoItem*)item;
-(void)removeItem:(ToDoItem*)item;


-(BOOL)canAddItem:(ToDoItem*)item;
-(BOOL)canRemoveItem:(ToDoItem*)item;

// Quick add and remove
-(void)addItemWithTitle:(NSString*)title;
-(void)removeItemWithTitle:(NSString*)title;
-(BOOL)canAddItemWithTitle:(NSString *)title;
-(BOOL)canRemoveItemWithTitle:(NSString*)title;
-(BOOL)hasItemWithTitle:(NSString*)title;

-(void)removeItemsAtIndexes:(NSIndexSet*)indexes;
-(NSArray*)itemTitles;
//-(NSArray*)allItems;
@property (readonly) NSArray* allItems;
-(NSUInteger)itemCount;


@end
