//
//  GameScene.m
//  Indoor Maps
//
//  Created by Muhammad Azam Baderi on 9/17/14.
//  Copyright (c) 2014 Muhammad Azam Baderi. All rights reserved.
//

#import "GameScene.h"

static NSString * const kAnimalNodeName = @"movable";

int tileMap[6][8] = {
    {1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1}
};

@interface GameScene()

@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end


@implementation GameScene {
    
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    
    myLabel.text = @"Indoor Maps";
    myLabel.fontSize = 45;
    myLabel.position = CGPointMake(450.0f, 300.0f);
    
    [self addChild:myLabel];
    
    struct Tile
    {
        bool walkable;
    };
    
    struct HeroPosition
    {
        int xTile;
        int yTile;
        int speed;
        float xPos;
        float yPos;
    };
    
    struct Tile tile0;
    struct Tile tile1;
    struct HeroPosition myHeroPosition;
    
    
    myHeroPosition.xTile = 2;
    myHeroPosition.yTile = 1;
    myHeroPosition.speed = 4;
    myHeroPosition.xPos = 300.0f;
    myHeroPosition.yPos = 640.0f;
    
    const int tileWidth = 30;
    const int tileHeight = 30;
    
    tile0.walkable = true;
    tile1.walkable = false;
    
    int saiz = 45
    ;
    for (int i = 0; i < 6; i++ )
    {
        for (int j = 0; j < 8; j++ )
        {
            NSLog(@"tileMap[%d][%d] = %d\n", i,j, tileMap[i][j] );
            if (tileMap[i][j] == 1) {
                NSLog(@"yes");
                SKSpriteNode *blue = [SKSpriteNode spriteNodeWithImageNamed:@"blue"];
                blue.xScale = 1.5;
                blue.yScale = 1.5;
                blue.position = CGPointMake(300.0f + j*saiz, 640.0f - i*saiz);
                
                [blue setName:kAnimalNodeName];
                [self addChild:blue];
            }
            if (tileMap[i][j] == 0) {
                NSLog(@"no");
                SKSpriteNode *green = [SKSpriteNode spriteNodeWithImageNamed:@"green"];
                green.xScale = 1.5;
                green.yScale = 1.5;
                green.position = CGPointMake(300.0f + j*saiz, 640.0f - i*saiz);
                [green setName:kAnimalNodeName];
                [self addChild:green];
            }
        }
    }
    
    SKSpriteNode *hero = [SKSpriteNode spriteNodeWithImageNamed:@"Red"];
    hero.xScale = 1.5;
    hero.yScale = 1.5;
    hero.position = CGPointMake(300.0f, 640.0f);
    
    [hero setName:kAnimalNodeName];
    [self addChild:hero];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    //2
    if(![_selectedNode isEqual:touchedNode]) {
        [_selectedNode removeAllActions];
        [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
        _selectedNode = touchedNode;
        //3
        if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
            [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
        }
    }
    
}

float degToRad(float degree) {
    return degree / 180.0f * M_PI;
}

@end
