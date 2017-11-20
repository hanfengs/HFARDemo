//
//  SCNViewController.m
//  HFARKit
//
//  Created by hanfeng on 2017/11/10.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "SCNViewController.h"
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface SCNViewController ()

//AR视图：展示3D界面
@property(nonatomic,strong)ARSCNView *arSCNView;
//AR会话，负责管理相机追踪配置及3D相机坐标
@property(nonatomic,strong)ARSession *arSession;
//会话追踪配置：负责追踪相机的运动
@property(nonatomic,strong)ARWorldTrackingConfiguration *arSessionConfiguration;

@end

@implementation SCNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark-

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.arSCNView];
    [self.arSession runWithConfiguration:self.arSessionConfiguration];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    //art.scnassets/model2/model2.scn
    //art.scnassets/Pikachu/PikachuF_ColladaMax.DAE
    //art.scnassets/ship.scn
    
    SCNNode *node = scene.rootNode.childNodes[0];
    node.position = SCNVector3Make(0, -1, -1);
    
    [self.arSCNView.scene.rootNode addChildNode:node];    
}


#pragma mark-
- (ARSCNView *)arSCNView{
    if (_arSCNView == nil) {
        _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        _arSCNView.session = self.arSession;
        
    }
    return _arSCNView;
}

-(ARSession *)arSession{
    if (_arSession == nil) {
        _arSession = [[ARSession alloc] init];
        
    }
    return _arSession;
}

- (ARWorldTrackingConfiguration *)arSessionConfiguration{
    if (_arSessionConfiguration == nil) {
        _arSessionConfiguration = [[ARWorldTrackingConfiguration alloc] init];
        _arSessionConfiguration.planeDetection = ARPlaneDetectionHorizontal;
        _arSessionConfiguration.lightEstimationEnabled = YES;
    }
    return _arSessionConfiguration;
}

@end
