//
//  ElementsDetailViewTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsDetailViewTableViewController.h"


@interface ElementsDetailViewTableViewController ()
@property (nonatomic) NSMutableArray *favorites;

@end

@implementation ElementsDetailViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailNavItem.title = self.name;
    //self.guidelinesTitle.text = self.guidelines;
    [self formatTextData];
}
-(void)viewWillAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.equipment.length >=1) {
        return 5;
    }else{
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (IBAction)handleCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)formatTextData{
    
    //set numberOfLines to 0 as default
    self.variationsTitle.numberOfLines = 0;
    self.guidelinesTitle.numberOfLines = 0;
    self.desiredOutcomesTitle.numberOfLines = 0;
    self.reflectionQuestionsTitle.numberOfLines = 0;
    self.equipmentTitle.numberOfLines = 0;
    
    //These do not need formatting
    self.guidelinesTitle.text = self.guidelines;
    
    
    //These need formatting
    NSArray *equipmentArray = [self.equipment componentsSeparatedByString:@"@"];
    if (equipmentArray.count >1) {
        self.equipmentTitle.text = [equipmentArray componentsJoinedByString:@"\n"];
    }else{
        if (self.equipment.length >1) {
            self.equipmentTitle.text = self.equipment;
        }else{
            self.equipmentTitle.text = @"There isn't any equipment needed";
        }
    }
    NSArray *variationsArray = [self.variations componentsSeparatedByString:@"@"];
    NSLog(@"variationsArray is %@", variationsArray);
    if ([[variationsArray objectAtIndex:0]isEqualToString:@""]|| [[variationsArray objectAtIndex:0]isEqualToString:@" "]) {
        self.variationsTitle.text = @"There aren't any variations on file";
    }else{
        self.variationsTitle.text = [variationsArray componentsJoinedByString:@"\n"];
        
    }
    
    NSArray *questionsArray = [self.reflectionQuestions componentsSeparatedByString:@"?"];
    NSLog(@"questionsArray is %@", questionsArray);
    if ([[questionsArray objectAtIndex:0]isEqualToString:@""]|| [[questionsArray objectAtIndex:0]isEqualToString:@" "]) {
        self.reflectionQuestionsTitle.text = @"There aren't any reflection questions on file";
        
    }else{
        self.reflectionQuestionsTitle.text = [questionsArray componentsJoinedByString:@"?\n"];
    }
    
    NSArray *desiredOutcomesArray = [self.desiredOutcomes componentsSeparatedByString:@"@"];
    self.desiredOutcomesTitle.text = [desiredOutcomesArray componentsJoinedByString:@"\n"];
    NSArray *titleArray = @[self.desiredOutcomesTitle, self.reflectionQuestionsTitle, self.variationsTitle, self.guidelinesTitle, self.equipmentTitle];
    for (UILabel *label in titleArray) {
        [label sizeToFit];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
-(void)scrollViewDidScroll: (UIScrollView*)scrollView
{
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        
        NSLog(@"We are at the top");
    }
    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    {
        
        // then we are at the end
        NSLog(@"We are at the bottom");
    }
}


@end
