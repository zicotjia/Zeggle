//
//  MusicPlayer.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//
import AudioToolbox

class MyMusicPlayer {

    static let sharedInstance = MyMusicPlayer()!

    private var musicPlayer: MusicPlayer?
    private var processingGraph: AUGraph

    init?() {
        var processingGraph: AUGraph?
        NewAUGraph(&processingGraph)

        guard let processingGraph = processingGraph else {
            return nil
        }

        self.processingGraph = processingGraph
        self.refreshMusicPlayer()
        self.generateAUNode(preset: 0)
    }

    func playTrack(track: Track) {
            DispatchQueue.main.async {
                let sequence = track.createSequence()
                self.refreshMusicPlayer()
                MusicPlayerSetSequence(self.musicPlayer!, sequence)
                MusicSequenceSetAUGraph(sequence, self.processingGraph)
                MusicPlayerStart(self.musicPlayer!)
            }
    }

    func musicPlayerIsActive() -> Bool {
        var isPlaying: DarwinBoolean = false
        MusicPlayerIsPlaying(self.musicPlayer!, &isPlaying)
        return isPlaying == true
    }

    func playNote(noteBeat: NoteBeat) {
        DispatchQueue.main.async {
            let track = Track(notes: [noteBeat])
            let sequence = track.createSequence()
            self.refreshMusicPlayer()
            MusicPlayerSetSequence(self.musicPlayer!, sequence)
            MusicSequenceSetAUGraph(sequence, self.processingGraph)
            MusicPlayerStart(self.musicPlayer!)
        }
    }

    private func refreshMusicPlayer() {
        NewMusicPlayer(&musicPlayer)
    }

    private func addSamplerNode() -> AUNode {
        var samplerNode: AUNode = AUNode()

        var componentDescription: AudioComponentDescription = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_MusicDevice),
            componentSubType: OSType(kAudioUnitSubType_Sampler),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0,
            componentFlagsMask: 0)

        AUGraphAddNode(self.processingGraph, &componentDescription, &samplerNode)
        return samplerNode
    }

    private func addIONode() -> AUNode {
        var ioNode: AUNode = AUNode()
        var ioUnitDescription: AudioComponentDescription = AudioComponentDescription(
            componentType: OSType(kAudioUnitType_Output),
            componentSubType: OSType(kAudioUnitSubType_RemoteIO),
            componentManufacturer: OSType(kAudioUnitManufacturer_Apple),
            componentFlags: 0,
            componentFlagsMask: 0)

        AUGraphAddNode(self.processingGraph, &ioUnitDescription, &ioNode)
        return ioNode
    }

    private func addSamplerUnit(samplerNode: AUNode) -> AudioUnit {
        var samplerUnit: AudioUnit?

        AUGraphNodeInfo(self.processingGraph, samplerNode, nil, &samplerUnit)

        guard let samplerUnit = samplerUnit else {
            fatalError()
        }

        return samplerUnit
    }

    private func addIOUnit(ioNode: AUNode) -> AudioUnit {
        var ioUnit: AudioUnit?

        AUGraphNodeInfo(self.processingGraph, ioNode, nil, &ioUnit)

        guard let ioUnit = ioUnit else {
            fatalError()
        }
        return ioUnit
    }

    private func connectNode(samplerNode: AUNode, ioNode: AUNode) {
        let ioUnitOutputElement: AudioUnitElement = 0
        let samplerOutputElement: AudioUnitElement = 0

        AUGraphConnectNodeInput(self.processingGraph,
            samplerNode, samplerOutputElement,
            ioNode, ioUnitOutputElement)
    }

    private func initializeGraph() {

        var outIsInitialized: DarwinBoolean = false

        AUGraphIsInitialized(self.processingGraph, &outIsInitialized)
        if outIsInitialized == false {
            AUGraphInitialize(self.processingGraph)
        }

        var isRunning: DarwinBoolean = false

        AUGraphIsRunning(self.processingGraph, &isRunning)

        if isRunning == false {
            AUGraphStart(self.processingGraph)
        }
    }

    private func generateAUNode(preset: UInt8) {
        let samplerNode = addSamplerNode()
        let ioNode = addIONode()

        AUGraphOpen(processingGraph)

        _ = addIOUnit(ioNode: ioNode)
        let samplerUnit = addSamplerUnit(samplerNode: samplerNode)

        connectNode(samplerNode: samplerNode, ioNode: ioNode)

        initializeGraph()

        func loadSF2Preset(preset: UInt8) {
            if let bankURL = Bundle.main.url(forResource: "Best of Guitars-4U-v1.0", withExtension: "sf2") {
                var instdata = AUSamplerInstrumentData(fileURL: Unmanaged.passUnretained(bankURL as CFURL),
                        instrumentType: UInt8(kInstrumentType_DLSPreset),
                        bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
                        bankLSB: UInt8(kAUSampler_DefaultBankLSB),
                        presetID: preset)

                AudioUnitSetProperty(
                        samplerUnit,
                        UInt32(kAUSamplerProperty_LoadInstrument),
                        UInt32(kAudioUnitScope_Global),
                        0,
                        &instdata,
                        UInt32(MemoryLayout<AUSamplerInstrumentData>.size))
            }
        }

        loadSF2Preset(preset: preset)
    }

}
