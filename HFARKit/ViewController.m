//
//  ViewController.m
//  HFARKit
//
//  Created by hanfeng on 2017/11/8.
//  Copyright © 2017年 hanfeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate, ARSessionDelegate>

//@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;
@property (nonatomic, strong) ARSCNView *sceneView;

//AR会话，负责管理相机追踪配置及3D相机坐标
@property(nonatomic,strong)ARSession *arSession;

//会话追踪配置
@property(nonatomic,strong) ARWorldTrackingConfiguration *arSessionConfiguration;

//Node对象
@property(nonatomic, strong) SCNNode *sunNode;
@property(nonatomic, strong) SCNNode *sunNodeL;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    // Set the view's delegate
//    self.sceneView.delegate = self;
//
//    // Show statistics such as fps and timing information
//    self.sceneView.showsStatistics = YES;
//
//    // Create a new scene
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
//
//    // Set the scene to the view
//    self.sceneView.scene = scene;
    
    self.sceneView.session = self.arSession;
    self.sceneView.automaticallyUpdatesLighting = YES;
    self.sceneView.showsStatistics = NO;
    self.sceneView.delegate = self;
    
    [self initNodeWithRootView:self.sceneView];
}

- (void)initNodeWithRootView:(SCNView *) scnView{
    
    _sunNode = [[SCNNode alloc] init];
    _sunNode.geometry = [SCNSphere sphereWithRadius:0.5];
    [_sunNode setPosition:SCNVector3Make(0, -1, 3)];
    
    [scnView.scene.rootNode addChildNode:_sunNode];
    
    ///Users/hanfeng/Desktop/demo/HFARKit/HFARKit/art.scnassets/sun-halo.png
    ///Users/hanfeng/Desktop/demo/HFARKit/HFARKit/art.scnassets/sun.jpg
    _sunNode.geometry.firstMaterial.multiply.contents = @"art.scnassets/texture.png";
    _sunNode.geometry.firstMaterial.diffuse.contents = @"art.scnassets/texture.png";
    _sunNode.geometry.firstMaterial.multiply.intensity = 0.5;
    _sunNode.geometry.firstMaterial.lightingModelName = SCNLightingModelConstant;
    
    _sunNode.geometry.firstMaterial.multiply.wrapS =
    _sunNode.geometry.firstMaterial.diffuse.wrapS  =
    _sunNode.geometry.firstMaterial.multiply.wrapT =
    _sunNode.geometry.firstMaterial.diffuse.wrapT  = SCNWrapModeRepeat;
    
    _sunNode.geometry.firstMaterial.locksAmbientWithDiffuse = YES;
    
}
#pragma mark-

- (ARSession *)arSession{
    if (_arSession == nil) {
        _arSession = [[ARSession alloc] init];
        _arSession.delegate = self;
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

#pragma mark-
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    /*
     1;  ARSessionConfiguration是一个父类，为了更好的看到增强现实的效果，苹果官方建议我们使用它的子类ARWorldTrackingSessionConfiguration，该类只支持A9芯片之后的机型，也就是iPhone6s之后的机型
     2;  ARWorldTrackingSessionConfiguration在最新的iOS 11 beta8中已被废弃，因此以下更改为ARWorldTrackingConfiguration;其中包含VIO；相机姿态估计，算法复杂，调用硬件各种传感器检测手机的移动翻滚姿态等。。
     */
//    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
//
//    // Run the view's session
//    [self.sceneView.session runWithConfiguration:configuration];
    
    [self.arSession runWithConfiguration:self.arSessionConfiguration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
