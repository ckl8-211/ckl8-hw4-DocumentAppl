//
//  ViewController.h
//  ckl8-HW4-DocumentToDo
//
//  Created by rlam on 3/12/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ToDoList;
@interface ViewController : NSViewController
@property (strong, nonatomic) ToDoList *todoList;
@end

