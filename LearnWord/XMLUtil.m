//
//  XMLUtil.m
//  LearnWord
//
//  Created by Alan on 16/11/17.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import "XMLUtil.h"

@implementation XMLUtil

- (instancetype)init{
    self = [super init];
    if (self) {
        //获取事先准备好的XML文件
        NSBundle *b = [NSBundle mainBundle];
        NSString *path = [b pathForResource:@"四级考试词汇必备" ofType:@".xml"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        self.par = [[NSXMLParser alloc]initWithData:data];
        //添加代理
        self.par.delegate = self;
        //初始化数组，存放解析后的数据
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

//几个代理方法的实现，是按逻辑上的顺序排列的，但实际调用过程中中间三个可能因为循环等问题乱掉顺序
//开始解析
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidStartDocument...");
}
//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    
    if ([self.currentElement isEqualToString:@"item"]){
        self.wordItem = [[WordItem alloc]init];
        
    }
    
}
//获取节点内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if ([self.currentElement isEqualToString:@"word"]) {
        
        [self.wordItem setWord:string];
    }else if ([self.currentElement isEqualToString:@"trans"]){
        [self.wordItem setTrans:string];
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    
    if ([elementName isEqualToString:@"item"]) {
        [self.list addObject:self.wordItem];
    }
    self.currentElement = nil;
}

//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"parserDidEndDocument...");
}

//外部调用接口
-(void)parse{
    [self.par parse];
    
}

@end
