//
//  PCETodoList.m
//  UWTodoApp
//
//  Created by Martin Nash on 7/8/14.
//  Copyright (c) 2014 Martin Nash (UW). All rights reserved.
//

#import "ToDoList.h"
#import "ToDoItem.h"

// class extension
// private properties
@interface ToDoList ()
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation ToDoList


-(instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _itemsArray = [NSMutableArray new];
        _allowsDuplicates = YES;
        _title = [title copy];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:@""];
}



#pragma mark - Item methods

-(void)addItem:(ToDoItem*)item
{
    if (![self canAddItem:item]) {
        return;
    }
    
    [_itemsArray addObject:item];
}

-(void)removeItem:(ToDoItem *)item
{
    if (![self hasItemWithTitle:item.title]) {
        return;
    }
    
    NSUInteger itemIndex = [[self itemTitles] indexOfObject:item.title];
    [self.itemsArray removeObjectAtIndex:itemIndex];
}

-(BOOL)canAddItem:(ToDoItem*)item
{
    return [self canAddItemWithTitle:item.title];
}

-(BOOL)canRemoveItem:(ToDoItem*)item
{
    return [self canRemoveItemWithTitle:item.title];
}


#pragma mark - Item Title methods

-(void)addItemWithTitle:(NSString*)title
{
    // illegal operation; early return
    if (![self canAddItemWithTitle:title]) {
        return;
    }
    
    ToDoItem *item = [ToDoItem todoItemWithTitle:title];
    [self addItem: item];
}

-(void)removeItemWithTitle:(NSString *)title
{
    if (![self hasItemWithTitle:title]) {
        return;
    }
    
    [self removeItem: [ToDoItem todoItemWithTitle:title]];
}

-(BOOL)canAddItemWithTitle:(NSString *)title
{
    if ([title isEqualToString:@""]) {
        return NO;
    }

    if (self.allowsDuplicates) {
        return YES;
    }
    
    // no duplicates
    // may add if item doesn't already exist
    return ![self hasItemWithTitle:title];
}

-(BOOL)canRemoveItemWithTitle:(NSString *)title
{
    return [self hasItemWithTitle:title];
}

-(BOOL)hasItemWithTitle:(NSString*)title
{
    return [[self itemTitles] containsObject:title];
}



#pragma mark - Array methods

-(NSArray*)itemTitles
{
    
    NSMutableArray *itemTitles = [NSMutableArray array];
    for (ToDoItem *oneItem in self.itemsArray) {
        [itemTitles addObject: oneItem.title];
    }

    
    [self.itemsArray enumerateObjectsUsingBlock:^(ToDoItem *obj, NSUInteger idx, BOOL *stop) {
        [itemTitles addObject:obj.title];
    }];
    return [NSArray arrayWithArray:itemTitles];
}

-(NSArray*)allItems
{
    // create and return new array
    // don't want to return mutable array
    return [NSArray arrayWithArray:self.itemsArray];
}

-(NSUInteger)itemCount
{
    return self.itemsArray.count;
}


-(void)removeItemsAtIndexes:(NSIndexSet*)indexes
{
    [self.itemsArray removeObjectsAtIndexes:indexes];
}
#pragma mark - Custom Description

-(NSString*)description
{
    NSMutableString *mutableString = [NSMutableString stringWithString:@"TodoList:\n"];
    for (ToDoItem *item in self.itemsArray) {
        [mutableString appendFormat: @"\t%@\n", item];
    }
    return mutableString;
}

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self forKey:@"itemsArray"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.itemsArray = [aDecoder decodeObjectForKey:@"itemsArray"];
    }
    return self;
}

@end
