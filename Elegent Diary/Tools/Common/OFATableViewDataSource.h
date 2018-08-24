//
//  OFATableViewDataSource.h
//  OnceForAll
//
//  Created by lwhldy on 2017/7/6.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);
typedef void (^TableViewCellCommitEditingBlock)(UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath, id item);

@interface OFATableViewDataSource : NSObject <UITableViewDataSource>


/**
 本类只支持一维数组通用模式
 
 @param anItems 数据数组
 @param aCellIdentifier 标识
 @param aConfigureBlcok cell内部处理的Block
 @return 自定义的TableViewDataSource
 */
- (instancetype)initWithItems:(NSArray*)anItems
               cellIdentifier:(NSString*)aCellIdentifier
               configureBlock:(TableViewCellConfigureBlock)aConfigureBlcok;

- (instancetype)itemAtIndexPath:(NSIndexPath*)indexPath;

- (void)commitEditingTableViewWithBlock:(TableViewCellCommitEditingBlock)aCommitEditingBlock;

@end
