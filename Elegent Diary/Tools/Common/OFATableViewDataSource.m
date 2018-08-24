//
//  OFATableViewDataSource.m
//  OnceForAll
//
//  Created by lwhldy on 2017/7/6.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "OFATableViewDataSource.h"

@interface OFATableViewDataSource ()

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, copy) TableViewCellCommitEditingBlock commitEditingBlock;
@end

@implementation OFATableViewDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureBlock:(TableViewCellConfigureBlock)aConfigureBlcok {
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureBlcok;
    }
    return self;
}


- (instancetype)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    
    return cell;
}

- (void)commitEditingTableViewWithBlock:(TableViewCellCommitEditingBlock)aCommitEditingBlock {
    self.commitEditingBlock = aCommitEditingBlock;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath];
    if (self.commitEditingBlock) {
        self.commitEditingBlock(editingStyle, indexPath, item);
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commitEditingBlock) {
        return YES;
    }
    return NO;
}

@end
