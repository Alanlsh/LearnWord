//
//  XMLUtil.h
//  LearnWord
//
//  Created by Alan on 16/11/17.
//  Copyright © 2016年 Alan. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "WordItem.h"
//声明代理
@interface XMLUtil : NSObject<NSXMLParserDelegate>
//添加属性
@property (nonatomic, strong) NSXMLParser *par;
@property (nonatomic, strong) WordItem *wordItem;
//存放每个person
@property (nonatomic, strong) NSMutableArray *list;
//标记当前标签，以索引找到XML文件内容
@property (nonatomic, copy) NSString *currentElement;

//声明parse方法，通过它实现解析
-(void)parse;
@end
