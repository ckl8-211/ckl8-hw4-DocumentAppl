//
//  ViewController.m
//  ckl8-HW4-DocumentToDo
//
//  Created by rlam on 3/12/15.
//  Copyright (c) 2015 rlam. All rights reserved.
//

#import "ViewController.h"
#import "NSTableView+SelectionStatus.h"
#import "TodoList.h"
#import "TodoItem.h"
@interface ViewController () <NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property (unsafe_unretained) IBOutlet NSTextView *docContent;

@property (weak) IBOutlet NSButton *addItem;

@property (weak) IBOutlet NSTableView *docTableView;

@property (weak) IBOutlet NSTextField *docTitle;

@property (weak) IBOutlet NSButton *deleteItem;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.docTitle.delegate = self;
    self.docTableView.delegate = self;
    self.docTableView.dataSource = self;
    self.docTableView.allowsMultipleSelection = YES;
    
}

#pragma mark - Actions

- (IBAction)clickedAddButton:(id)sender
{
    [self.todoList addItemWithTitle:@"New Item"];
    NSIndexSet *lastIndex = [NSIndexSet indexSetWithIndex: self.docTableView.numberOfRows];
    [self.docTableView insertRowsAtIndexes:lastIndex withAnimation:NSTableViewAnimationSlideDown];
}

- (IBAction)clickedDeleteButton:(id)sender
{
    NSIndexSet *indexes = self.docTableView.selectedRowIndexes;
    [self.todoList removeItemsAtIndexes:indexes];
    [self.docTableView removeRowsAtIndexes:indexes withAnimation:NSTableViewAnimationEffectFade];
}

#pragma mark - Table View

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.todoList itemCount];
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *tcv = [tableView makeViewWithIdentifier:@"BasicCell" owner:nil];
    tcv.textField.stringValue = [self.todoList itemTitles][row];
    return tcv;
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
    [self updateUI];
}

-(ToDoItem*)selectedItem
{
        if (self.docTableView.selectionStatus == TableViewSelectionStatusSingle) {
    NSUInteger idx = self.docTableView.selectedRowIndexes.firstIndex;
    return [self.todoList allItems][idx];
        }
    
        return nil;
}

-(void)updateUI
{
        self.addItem.enabled = YES;
        self.deleteItem.enabled = self.docTableView.hasSelection;
        self.docContent.editable = self.docTableView.selectionStatus == TableViewSelectionStatusSingle;
        self.docTitle.editable = self.docTableView.selectionStatus == TableViewSelectionStatusSingle;
    
        if (self.docTableView.selectionStatus == TableViewSelectionStatusSingle) {
    ToDoItem *item = [self selectedItem];
    if (item) {
        self.docTitle.stringValue = item.title;
        self.docContent.string = item.contents;
    }
    
        } else {
            self.docContent.editable = NO;
            self.docContent.string = @"";
            self.docTitle.stringValue = @"";
        }
}




#pragma mark - Content Text View

-(void)textDidChange:(NSNotification *)notification
{
    if (notification.object == self.docContent) {
        [[self selectedItem] setContents:self.docContent.string];
        [self.docTableView reloadDataForRowIndexes:self.docTableView.selectedRowIndexes columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
}



#pragma mark - Title Text Field

-(void)controlTextDidChange:(NSNotification *)note
{
    if (note.object == self.docTitle) {
        [[self selectedItem] setTitle:self.docTitle.stringValue];
        [self.docTableView reloadDataForRowIndexes:self.docTableView.selectedRowIndexes columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
}

@end

