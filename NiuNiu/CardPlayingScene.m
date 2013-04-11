//
//  CardPlayingScene.m
//  NiuNiu 牌局
//
//  Created by childhood on 13-4-7.
//
//

#import "CardPlayingScene.h"
#import "FamilyPropertyScene.h"
#import "PawnShopScene.h"
#import "Game.h"

@implementation CardPlayingScene
@synthesize swipeLeftGestureRecognizer=_swipeLeftGestureRecognizer;
@synthesize swipeRightGestureRecognizer=_swipeRightGestureRecognizer;

+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
	CardPlayingScene *layer = [CardPlayingScene node];
    [scene addChild: layer];
	return scene;
}

-(id)init
{
    if( (self=[super init]) ) {
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"牌局" fontName:@"Marker Felt" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp( size.width /2 , size.height/2 );
		[self addChild: label];
        
        CCMenuItemImage *backImg = [CCMenuItemImage itemWithNormalImage:@"back.png"
                                                          selectedImage:@"back.png"
                                                                  block:^(id sender){
                                                                      [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[FamilyPropertyScene scene] withColor:ccWHITE]];                                                                  }];
        backImg.position = ccp(backImg.contentSize.width / 2, size.height / 2 - backImg.contentSize.height / 2);
        CCLOG(@"backImg.contentSize / 2:%f", backImg.contentSize.width / 2);
        CCLOG(@"backImg.postion-x:%f, y:%f", backImg.position.x,backImg.position.y);
        backImg.scaleX = -1;
        
        CCMenuItemImage *preImg = [CCMenuItemImage itemWithNormalImage:@"back.png"
                                                         selectedImage:@"back.png"
                                                                 block:^(id sender){
                                                                     [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[PawnShopScene scene] withColor:ccWHITE]];
                                                                 }];
        preImg.position = ccp(size.width - backImg.contentSize.width / 2, size.height /2 - backImg.contentSize.height / 2);
        CCMenu *navigateMenu = [CCMenu menuWithItems:backImg,preImg, nil];
        [navigateMenu setPosition:CGPointZero];
        [self addChild:navigateMenu];
    }
    return self;
}

#pragma mark - UISwipeGesture switch-scenes
- (void)switchSceneToPawnShop:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:[FamilyPropertyScene scene]
                                                                             withColor:ccWHITE]];
}

- (void)switchSceneToCardPlay:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:[PawnShopScene scene]
                                                                             withColor:ccWHITE]];
}

- (void)onEnter
{
    self.swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(switchSceneToPawnShop:)];
    self.swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:self.swipeLeftGestureRecognizer];
    
    self.swipeRightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(switchSceneToCardPlay:)];
    self.swipeRightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:self.swipeRightGestureRecognizer];
    [super onEnter];
    LOG_FUN_DID;
}

- (void)onEnterTransitionDidFinish
{
    [super onEnterTransitionDidFinish];
    LOG_FUN_DID;
}

- (void)onExit
{
    [[[CCDirector sharedDirector] view] removeGestureRecognizer:_swipeLeftGestureRecognizer];
    [[[CCDirector sharedDirector] view] removeGestureRecognizer:_swipeRightGestureRecognizer];
    [super onExit];
    LOG_FUN_DID;
}

- (void) dealloc
{
	[_swipeLeftGestureRecognizer release];
    _swipeLeftGestureRecognizer = nil;
    [_swipeRightGestureRecognizer release];
    _swipeRightGestureRecognizer = nil;
    
	[super dealloc];
}


@end
