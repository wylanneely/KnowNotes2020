//
//  RecognizeWritingSetObjectVC.swift
//  LearnAlphaVision
//
//  Created by Wylan L Neely on 1/13/21.
//

import UIKit
import SceneKit
import ARKit
import RealityKit

class RecognizeWritingSetObjectVC: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var displayText: UITextView!
    @IBOutlet weak var sceneView: VirtualObjectARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
        let panGesture = ThresholdPanGesture(target: self, action: #selector(didPan(_:)))
        panGesture.delegate = self

        // Add gestures to the `sceneView`.
         sceneView.addGestureRecognizer(panGesture)
        // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
        // Do any additional setup after loading the view.
    }
    
    //MARK: Writting Recognition
    
    var detectionFrame: ARFrame?
    var readSession = AVCaptureSession()
    var readRequests = [VNRequest]()
    var textResults: [VNRecognizedTextObservation]?
    var textRecognitionRequest = VNRecognizeTextRequest()
    private var confidence: VNConfidence = 0.0
    //MARK: Text Analyzing
    // The pixel buffer being held for analysis; used to serialize Vision requests.
    private var currentBuffer: CVPixelBuffer?
    // Queue for dispatching vision classification requests
    private let visionQueue = DispatchQueue(label: "com.example.apple-samplecode.ARKitVision.serialVisionQueue")
    
    var userMatchedWord: Bool {
        if customWords.contains(writtenWord) {
            DispatchQueue.main.async {
                self.displayText.textColor = UIColor.systemGreen
            }
            return true
        } else {
            DispatchQueue.main.async {
                self.displayText.textColor = UIColor.systemRed
            }
            return false
        }
    }
    
    var writtenWord: String = ""
    let customWords: [String] = ["donut","sun","moon","lamp","vase","cup","chair","painting","candle","ship"]
    
    func setUpTextRequest() {
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.customWords = customWords
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            if let results = request.results,
               !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    for textObservation in requestResults {
                        for text in textObservation.topCandidates(1) {
                            let writtenLowercased = text.string.lowercased()
                            if self.customWords.contains(writtenLowercased) {
                                self.writtenWord = text.string
                                self.confidence = text.confidence
                                break
                            }
                        }
                    }
                }
                print(self.writtenWord)
                print(self.confidence)
                defer { self.currentBuffer = nil }
                DispatchQueue.main.async {
                    if self.userMatchedWord {
                        self.displayText.textColor = UIColor.green
                        self.displayText.text = self.writtenWord
                    }
                }
            }
        })
    }
    private func classifyCurrentImage() {
        guard let orientation = CGImagePropertyOrientation(rawValue: 6),
              let currentBuffer = currentBuffer else {
            DispatchQueue.main.async {
                self.displayText.text = "Error getting Device Orientation" } ; return
        }
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: currentBuffer, orientation: orientation)
        visionQueue.async {
            do {
                //     defer { self.currentBuffer = nil }
                try requestHandler.perform([self.textRecognitionRequest])
            } catch {
                print("Error: Vision request failed with error \"\(error)\"")
            }
        }
    }
    // Pass camera frames received from ARKit to Vision (when not already processing one)
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Retain the image buffer for Vision processing.didTap
        if userMatchedWord == false {
            self.currentBuffer = frame.capturedImage
            print(frame.camera)
            classifyCurrentImage()
        }
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        // Filter out optional error messages.
        DispatchQueue.main.async {
            self.displayText.text = "The AR session failed."
        }
    }

    // MARK: for the Focus Square
    // SUPER IMPORTANT: the screenCenter must be defined this way
    func hideFocusSquare()  { DispatchQueue.main.async { self.updateFocusSquare(isObjectVisible: true) } }  // to hide the focus square
    func showFocusSquare()  { DispatchQueue.main.async { self.updateFocusSquare(isObjectVisible: false) } } // to show the focus square

    var focusSquare = FocusSquare()
    var screenCenter: CGPoint {
        let bounds = sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    var isFocusSquareEnabled : Bool = true


    // MARK: - Pan Gesture Block
    // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
    
    /// The tracked screen position used to update the `trackedObject`'s position in `updateObjectToCurrentTrackingPosition()`.
    private var currentTrackingPosition: CGPoint?
    /**
     The object that has been most recently intereacted with.
     The `selectedObject` can be moved at any time with the tap gesture.
     */
    var selectedObject: VirtualObject?
    /// The object that is tracked for use by the pan and rotation gestures.
    private var trackedObject: VirtualObject? {
        didSet {
            guard trackedObject != nil else { return }
            selectedObject = trackedObject
        }
    }
    /// Developer setting to translate assuming the detected plane extends infinitely.
    let translateAssumingInfinitePlane = true
    // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
    @objc func didPan(_ gesture: ThresholdPanGesture) {
        switch gesture.state {
        case .began:
            // Check for interaction with a new object.
            if let object = objectInteracting(with: gesture, in: sceneView) {
                trackedObject = object // as? VirtualObject
            }

        case .changed where gesture.isThresholdExceeded:
            guard let object = trackedObject else { return }
            let translation = gesture.translation(in: sceneView)

            let currentPosition = currentTrackingPosition ?? CGPoint(sceneView.projectPoint(object.position))

            // The `currentTrackingPosition` is used to update the `selectedObject` in `updateObjectToCurrentTrackingPosition()`.
            currentTrackingPosition = CGPoint(x: currentPosition.x + translation.x, y: currentPosition.y + translation.y)

            gesture.setTranslation(.zero, in: sceneView)

        case .changed:
            // Ignore changes to the pan gesture until the threshold for displacment has been exceeded.
            break

        case .ended:
            // Update the object's anchor when the gesture ended.
            guard let existingTrackedObject = trackedObject else { break }
            addOrUpdateAnchor(for: existingTrackedObject)
            fallthrough

        default:
            // Clear the current position tracking.
            currentTrackingPosition = nil
            trackedObject = nil
        }
    }

    // - MARK: Object anchors
    /// - Tag: AddOrUpdateAnchor
    func addOrUpdateAnchor(for object: VirtualObject) {
        // If the anchor is not nil, remove it from the session.
        if let anchor = object.anchor {
            sceneView.session.remove(anchor: anchor)
        }

        // Create a new anchor with the object's current transform and add it to the session
        let newAnchor = ARAnchor(transform: object.simdWorldTransform)
        object.anchor = newAnchor
        sceneView.session.add(anchor: newAnchor)
    }


    private func objectInteracting(with gesture: UIGestureRecognizer, in view: ARSCNView) -> VirtualObject? {
        for index in 0..<gesture.numberOfTouches {
            let touchLocation = gesture.location(ofTouch: index, in: view)

            // Look for an object directly under the `touchLocation`.
            if let object = virtualObject(at: touchLocation) {
                return object
            }
        }

        // As a last resort look for an object under the center of the touches.
        // return virtualObject(at: gesture.center(in: view))
        return virtualObject(at: (gesture.view?.center)!)
    }


    /// Hit tests against the `sceneView` to find an object at the provided point.
    func virtualObject(at point: CGPoint) -> VirtualObject? {

        // let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResults = sceneView.hitTest(point, options: [SCNHitTestOption.categoryBitMask: 0b00000010, SCNHitTestOption.searchMode: SCNHitTestSearchMode.any.rawValue as NSNumber])
        // let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        // let hitTestResults = sceneView.hitTest(point, options: hitTestOptions)

        return hitTestResults.lazy.compactMap { result in
            return VirtualObject.existingObjectContainingNode(result.node)
            }.first
    }

    /**
     If a drag gesture is in progress, update the tracked object's position by
     converting the 2D touch location on screen (`currentTrackingPosition`) to
     3D world space.
     This method is called per frame (via `SCNSceneRendererDelegate` callbacks),
     allowing drag gestures to move virtual objects regardless of whether one
     drags a finger across the screen or moves the device through space.
     - Tag: updateObjectToCurrentTrackingPosition
     */
    @objc
    func updateObjectToCurrentTrackingPosition() {
        guard let object = trackedObject, let position = currentTrackingPosition else { return }
        translate(object, basedOn: position, infinitePlane: translateAssumingInfinitePlane, allowAnimation: true)
    }

    /// - Tag: DragVirtualObject
    func translate(_ object: VirtualObject, basedOn screenPos: CGPoint, infinitePlane: Bool, allowAnimation: Bool) {
        guard let cameraTransform = sceneView.session.currentFrame?.camera.transform,
            let result = smartHitTest(screenPos,
                                      infinitePlane: infinitePlane,
                                      objectPosition: object.simdWorldPosition,
                                      allowedAlignments: [ARPlaneAnchor.Alignment.horizontal]) else { return }

        let planeAlignment: ARPlaneAnchor.Alignment
        if let planeAnchor = result.anchor as? ARPlaneAnchor {
            planeAlignment = planeAnchor.alignment
        } else if result.type == .estimatedHorizontalPlane {
            planeAlignment = .horizontal
        } else if result.type == .estimatedVerticalPlane {
            planeAlignment = .vertical
        } else {
            return
        }

        /*
         Plane hit test results are generally smooth. If we did *not* hit a plane,
         smooth the movement to prevent large jumps.
         */
        let transform = result.worldTransform
        let isOnPlane = result.anchor is ARPlaneAnchor
        object.setTransform(transform,
                            relativeTo: cameraTransform,
                            smoothMovement: !isOnPlane,
                            alignment: planeAlignment,
                            allowAnimation: allowAnimation)
    }
    
    // MARK: - Focus Square (code by Apple, some by me)
    func updateFocusSquare(isObjectVisible: Bool) {
        if isObjectVisible {
            focusSquare.hide()
        } else {
            focusSquare.unhide()
        }

        // Perform hit testing only when ARKit tracking is in a good state.
        if let camera = sceneView.session.currentFrame?.camera, case .normal = camera.trackingState,
            let result = smartHitTest(screenCenter) {
            DispatchQueue.main.async {
                self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
                self.focusSquare.state = .detecting(hitTestResult: result, camera: camera)
            }
        } else {
            DispatchQueue.main.async {
                self.focusSquare.state = .initializing
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
        }
    }
    
    func smartHitTest(_ point: CGPoint,
                      infinitePlane: Bool = false,
                      objectPosition: float3? = nil,
                      allowedAlignments: [ARPlaneAnchor.Alignment] = [.horizontal, .vertical]) -> ARHitTestResult? {

        // Perform the hit test.
        let results = sceneView.hitTest(point, types: [.existingPlaneUsingGeometry, .estimatedVerticalPlane, .estimatedHorizontalPlane])

        // 1. Check for a result on an existing plane using geometry.
        if let existingPlaneUsingGeometryResult = results.first(where: { $0.type == .existingPlaneUsingGeometry }),
            let planeAnchor = existingPlaneUsingGeometryResult.anchor as? ARPlaneAnchor, allowedAlignments.contains(planeAnchor.alignment) {
            return existingPlaneUsingGeometryResult
        }

        if infinitePlane {

            // 2. Check for a result on an existing plane, assuming its dimensions are infinite.
            //    Loop through all hits against infinite existing planes and either return the
            //    nearest one (vertical planes) or return the nearest one which is within 5 cm
            //    of the object's position.
            let infinitePlaneResults = sceneView.hitTest(point, types: .existingPlane)

            for infinitePlaneResult in infinitePlaneResults {
                if let planeAnchor = infinitePlaneResult.anchor as? ARPlaneAnchor, allowedAlignments.contains(planeAnchor.alignment) {
                    if planeAnchor.alignment == .vertical {
                        // Return the first vertical plane hit test result.
                        return infinitePlaneResult
                    } else {
                        // For horizontal planes we only want to return a hit test result
                        // if it is close to the current object's position.
                        if let objectY = objectPosition?.y {
                            let planeY = infinitePlaneResult.worldTransform.translation.y
                            if objectY > planeY - 0.05 && objectY < planeY + 0.05 {
                                return infinitePlaneResult
                            }
                        } else {
                            return infinitePlaneResult
                        }
                    }
                }
            }
        }

        // 3. As a final fallback, check for a result on estimated planes.
        let vResult = results.first(where: { $0.type == .estimatedVerticalPlane })
        let hResult = results.first(where: { $0.type == .estimatedHorizontalPlane })
        switch (allowedAlignments.contains(.horizontal), allowedAlignments.contains(.vertical)) {
        case (true, false):
            return hResult
        case (false, true):
            // Allow fallback to horizontal because we assume that objects meant for vertical placement
            // (like a picture) can always be placed on a horizontal surface, too.
            return vResult ?? hResult
        case (true, true):
            if hResult != nil && vResult != nil {
                return hResult!.distance < vResult!.distance ? hResult! : vResult!
            } else {
                return hResult ?? vResult
            }
        default:
            return nil
        }
    }
    
    //MARK: ARSCNDelegate
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // For the Focus Square
        if isFocusSquareEnabled { showFocusSquare() }

        self.updateObjectToCurrentTrackingPosition() // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if focusSquare.state != .initializing {
            let position = SCNVector3(focusSquare.lastPosition!)

            // *** FOR OBJECT DRAGGING PAN GESTURE - APPLE ***
            let testObject = VirtualObject() // give it some name, when you dont have anything to load
            testObject.geometry = SCNCone(topRadius: 0.0, bottomRadius: 0.2, height: 0.5)
            testObject.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            testObject.categoryBitMask = 0b00000010
            testObject.name = "test"
            testObject.castsShadow = true
            testObject.position = position

            sceneView.scene.rootNode.addChildNode(testObject)
        }
    }
}

extension RecognizeWritingSetObjectVC: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
            
        var requestOptions:[VNImageOption : Any] = [:]
            
        if let camData = CMGetAttachment(sampleBuffer, key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil) {
            requestOptions = [.cameraIntrinsics:camData]
        }
        if let orientation = CGImagePropertyOrientation(rawValue: 6) {
            
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation, options: requestOptions)
            
        do {
            try imageRequestHandler.perform(self.readRequests)
        } catch {
            print(error)
        }
        }
    }
}
