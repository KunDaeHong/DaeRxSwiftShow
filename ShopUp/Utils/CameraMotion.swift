//
//  CameraMotion.swift
//  ShopUp
//
//  Created by Daehyeon Hong on 2023/01/12.
//

import Foundation
import AVFoundation
import UIKit
import CoreImage
import CoreMedia
import CoreVideo

class CameraMotion: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // Using CameraMotion class in Public
    public static let shared = CameraMotion(cameraFrameSize: CGRect())
    private var frameSize: CGRect = CGRect()
    
    private var ciContext: CIContext?
    private let grayScaleFilter: CIFilter = CIFilter(name: "CIMaskToAlpha")!
    private var outputColorSpcase: CGColorSpace?
    private var outputPixelBufferPool: CVPixelBufferPool?
    
    var motionSizeView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    init(cameraFrameSize: CGRect){
        frameSize = cameraFrameSize
    }
    
    private func inputCamera(captureSession: AVCaptureSession) {
        reset()
        
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
        let videoOutput = AVCaptureVideoDataOutput()
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "video sample buffer delegate"))
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        captureSession.startRunning()
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = .portrait
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.main)
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        getGrayScaleOutput(cameraImg: CIImage(cvImageBuffer: pixelBuffer!))
    }
    
    private func getGrayScaleOutput(cameraImg: CIImage){
        grayScaleFilter.setValue(cameraImg, forKey: kCIInputImageKey)
        let cgImage = self.ciContext?.createCGImage(grayScaleFilter.outputImage!, from: cameraImg.extent)
        
        let provider = cgImage?.dataProvider
        let providerData = provider?.data
        let data = CFDataGetBytePtr(providerData)
        let bitmapInfo = cgImage?.bitmapInfo
        
        let width = cgImage?.width
        let height = cgImage?.height
        
        for pixel in cgImage?.bitsPerPixel {
            if cgImage.
        }
        
    }
    
    private func reset() {
        ciContext = nil
        outputColorSpcase = nil
        outputPixelBufferPool = nil
    }
    
}
