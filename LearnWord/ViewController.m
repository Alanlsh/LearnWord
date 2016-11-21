//
//  ViewController.m
//  LearnWord
//
//  Created by Alan on 16/11/17.
//  Copyright © 2016年 Alan. All rights reserved.
//

#define KHeight  self.view.frame.size.height
#define KWidth   self.view.frame.size.width


#import "ViewController.h"
#import "XMLUtil.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *wordLabel;

@property (nonatomic, strong) UITextView *desTextView;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIButton *lastButton;

@property (nonatomic, strong) UIButton *nextButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMLUtil *xmlUtil = [[XMLUtil alloc] init];
    
    [xmlUtil parse];
    
    self.dataArray = xmlUtil.list;
    
    
    [self.view addSubview:self.wordLabel];
    [self.view addSubview:self.desTextView];
    
    self.currentIndex = 0;
    [self loadWord:self.dataArray.firstObject];
    
    
    
    UIButton *lastButton = [[UIButton alloc] initWithFrame:CGRectMake(30, KHeight - 70,100, 50)];
    [lastButton setTitle:@"上一个" forState:UIControlStateNormal];
    lastButton.backgroundColor = [UIColor greenColor];
    [lastButton addTarget:self action:@selector(lastWordItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lastButton];
    self.lastButton = lastButton;
    
    
    
    
    
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(KWidth - 130, KHeight - 70,100, 50)];
    [nextButton setTitle:@"下一个" forState:UIControlStateNormal];
    nextButton.backgroundColor = [UIColor redColor];
    [nextButton addTarget:self action:@selector(nextWordItem) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
    
    if (self.currentIndex <= 0) {
        self.lastButton.userInteractionEnabled = NO;
        self.lastButton.backgroundColor = [UIColor grayColor];
    }
    
    
    if (self.currentIndex < self.dataArray.count - 1) {
        self.nextButton.userInteractionEnabled = YES;
        self.nextButton.backgroundColor = [UIColor redColor];
    }
    

    
}

/// 上一个
- (void)lastWordItem
{
    self.currentIndex = self.currentIndex - 1;
    
    for (NSInteger i = 0; i < self.currentIndex + 1; i ++ ) {
        
        self.currentIndex = self.currentIndex - i;
        
        WordItem *wordItem = self.dataArray[self.currentIndex];
        if (wordItem.word.length > 0) {
            if (wordItem.trans.length > 0) {
                
                if ([wordItem.trans containsString:@"【单词助记】"]) {
                    NSRange range = [wordItem.trans rangeOfString:@"【单词助记】"];
                    wordItem.trans = [wordItem.trans substringWithRange:NSMakeRange(0, range.location)];

                }
                
                if ([wordItem.trans containsString:@"更多资料下"]) {
                    NSRange range = [wordItem.trans rangeOfString:@"更多资料下"];
                    wordItem.trans = [wordItem.trans substringWithRange:NSMakeRange(0, range.location)];
                    
                }
                
                if (wordItem.trans.length > 0) {
                    [self loadWord:wordItem];
                    break;
                }
                
            }
            
            
            
            
        }
        
        
    }
    
    
    
//    [self loadWord:self.dataArray[self.currentIndex]];
    
    if (self.currentIndex <= 0) {
        self.lastButton.userInteractionEnabled = NO;
        self.lastButton.backgroundColor = [UIColor grayColor];
    }
    
    
    if (self.currentIndex < self.dataArray.count - 1) {
        self.nextButton.userInteractionEnabled = YES;
        self.nextButton.backgroundColor = [UIColor redColor];
    }
    
    
    
}

/// 下一个
- (void)nextWordItem
{
    self.currentIndex = self.currentIndex + 1;
    
    for (NSInteger i = 0; i < self.dataArray.count - 1 - self.currentIndex + 1; i ++ ) {
        
        self.currentIndex = self.currentIndex + i;
        
        WordItem *wordItem = self.dataArray[self.currentIndex];
        
        if (wordItem.word.length > 0) {
            if (wordItem.trans.length > 0) {
                
                if ([wordItem.trans containsString:@"【单词助记】"]) {
                    NSRange range = [wordItem.trans rangeOfString:@"【单词助记】"];
                    wordItem.trans = [wordItem.trans substringWithRange:NSMakeRange(0, range.location)];

                }
                
                if ([wordItem.trans containsString:@"更多资料下"]) {
                     NSRange range = [wordItem.trans rangeOfString:@"更多资料下"];
                    wordItem.trans = [wordItem.trans substringWithRange:NSMakeRange(0, range.location)];
                    
                }
                
                if (wordItem.trans.length > 0) {
                    [self loadWord:wordItem];
                    break;
                }
                
                
            }
            
            
            
            
        }
        
        
    }

    
    if (self.currentIndex >= self.dataArray.count - 1) {
        self.nextButton.userInteractionEnabled = NO;
        self.nextButton.backgroundColor = [UIColor grayColor];
    }
    
    
    if (self.currentIndex > 0) {
        self.lastButton.userInteractionEnabled = YES;
        self.lastButton.backgroundColor = [UIColor greenColor];
    }

}

// 加载单词数据
- (void)loadWord:(WordItem *)wordItem
{
    
//    NSString *str = @"\n";
//    NSMutableAttributedString *mutAttributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",wordItem.word,str,wordItem.trans]];
//    
////    [mutAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, wordItem.word.length)];
////    [mutAttributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:20] range:NSMakeRange(0, wordItem.word.length)];
//    
//    [mutAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(wordItem.word.length + str.length, wordItem.trans.length)];
//    [mutAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(wordItem.word.length + str.length, wordItem.trans.length)];
    
    
    

    self.wordLabel.text = wordItem.word;
    self.desTextView.text = wordItem.trans;
    
}









- (UILabel *)wordLabel
{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 40)];
        _wordLabel.textAlignment = NSTextAlignmentCenter;
        _wordLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:36];
        _wordLabel.textColor = [UIColor blackColor];
    }
    return _wordLabel;
}

- (UITextView *)desTextView
{

    if (!_desTextView) {
        _desTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, 170, self.view.frame.size.width - 100, 200)];
        _desTextView.textAlignment = NSTextAlignmentLeft;
        _desTextView.font = [UIFont systemFontOfSize:15];
        _desTextView.textColor = [UIColor redColor];
//        _desTextView.numberOfLines = 0;
    }
    return _desTextView;
}



@end
