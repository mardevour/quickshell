pragma Singleton
import QtQuick
import Quickshell.Services.Pipewire

Item {
    property var sink: Pipewire.defaultAudioSink
    property var source: Pipewire.defaultAudioSource

    property real volumeOut: sink ? sink.audio.volume : 0
    property real volumeIn: source ? source.audio.volume : 0

    PwObjectTracker {
        objects: [sink, source]

        onObjectsChanged: {
            if (sink && sink.audio) {
                sink.audio.volumeChanged.connect(updateVolumeOut);
            }
            if (source && source.audio) {
                source.audio.volumeChanged.connect(updateVolumeIn);
            }
        }
    }

    function setVolume(newValue) {
        volumeOut = newValue;
        sink.audio.volume = newValue;
    //console.log("vol changed: ", + newValue)
    }

    function toggleMute(object) {
        object = !object;
    }
}
