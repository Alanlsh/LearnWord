//
//  WordItem.h
//  LearnWord
//
//  Created by Alan on 16/11/17.
//  Copyright © 2016年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WordItem : NSObject

/// 英文单词
@property (nonatomic, copy) NSString *word;

/// 汉意
@property (nonatomic, copy) NSString *trans;

@end
