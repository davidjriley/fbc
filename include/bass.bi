/'
    BASS 2.4 C/C++ header file
    Copyright (c) 1999-2011 Un4seen Developments Ltd.

    See the BASS.CHM file for more detailed documentation
'/

#ifndef __bass_bi__
#define __bass_bi__

#inclib "bass"

#ifdef __FB_WIN32__
extern "Windows-MS"
#else
extern "C"
#endif

Type WORD as UShort
type DWORD as UInteger
type QWORD as ULongInt
type BOOL as integer


#Ifndef TRUE
    #define TRUE 1
    #define FALSE 0
#EndIf
#define MAKEWORD(a,b) Cast(WORD, ((a) And &hFF) Or ((b) Shl 8))
#define MAKELONG(a,b) Cast(DWORD, ((a) And &hFFFF) Or ((b) Shl 16))

#define BASSVERSION &h204
#define BASSVERSIONTEXT "2.4"

type HMUSIC as DWORD
type HSAMPLE as DWORD
type HCHANNEL as DWORD
type HSTREAM as DWORD
type HRECORD as DWORD
type HSYNC as DWORD
type HDSP as DWORD
type HFX as DWORD
type HPLUGIN as DWORD

#define BASS_OK 0
#define BASS_ERROR_MEM 1
#define BASS_ERROR_FILEOPEN 2
#define BASS_ERROR_DRIVER 3
#define BASS_ERROR_BUFLOST 4
#define BASS_ERROR_HANDLE 5
#define BASS_ERROR_FORMAT 6
#define BASS_ERROR_POSITION 7
#define BASS_ERROR_INIT 8
#define BASS_ERROR_START 9
#define BASS_ERROR_ALREADY 14
#define BASS_ERROR_NOCHAN 18
#define BASS_ERROR_ILLTYPE 19
#define BASS_ERROR_ILLPARAM 20
#define BASS_ERROR_NO3D 21
#define BASS_ERROR_NOEAX 22
#define BASS_ERROR_DEVICE 23
#define BASS_ERROR_NOPLAY 24
#define BASS_ERROR_FREQ 25
#define BASS_ERROR_NOTFILE 27
#define BASS_ERROR_NOHW 29
#define BASS_ERROR_EMPTY 31
#define BASS_ERROR_NONET 32
#define BASS_ERROR_CREATE 33
#define BASS_ERROR_NOFX 34
#define BASS_ERROR_NOTAVAIL 37
#define BASS_ERROR_DECODE 38
#define BASS_ERROR_DX 39
#define BASS_ERROR_TIMEOUT 40
#define BASS_ERROR_FILEFORM 41
#define BASS_ERROR_SPEAKER 42
#define BASS_ERROR_VERSION 43
#define BASS_ERROR_CODEC 44
#define BASS_ERROR_ENDED 45
#define BASS_ERROR_BUSY 46
#define BASS_ERROR_UNKNOWN -1
#define BASS_CONFIG_BUFFER 0
#define BASS_CONFIG_UPDATEPERIOD 1
#define BASS_CONFIG_GVOL_SAMPLE 4
#define BASS_CONFIG_GVOL_STREAM 5
#define BASS_CONFIG_GVOL_MUSIC 6
#define BASS_CONFIG_CURVE_VOL 7
#define BASS_CONFIG_CURVE_PAN 8
#define BASS_CONFIG_FLOATDSP 9
#define BASS_CONFIG_3DALGORITHM 10
#define BASS_CONFIG_NET_TIMEOUT 11
#define BASS_CONFIG_NET_BUFFER 12
#define BASS_CONFIG_PAUSE_NOPLAY 13
#define BASS_CONFIG_NET_PREBUF 15
#define BASS_CONFIG_NET_PASSIVE 18
#define BASS_CONFIG_REC_BUFFER 19
#define BASS_CONFIG_NET_PLAYLIST 21
#define BASS_CONFIG_MUSIC_VIRTUAL 22
#define BASS_CONFIG_VERIFY 23
#define BASS_CONFIG_UPDATETHREADS 24
#define BASS_CONFIG_DEV_BUFFER 27
#define BASS_CONFIG_IOS_MIXAUDIO 34
#define BASS_CONFIG_DEV_DEFAULT 36
#define BASS_CONFIG_NET_READTIMEOUT 37
#define BASS_CONFIG_IOS_SPEAKER 39
#define BASS_CONFIG_NET_AGENT 16
#define BASS_CONFIG_NET_PROXY 17
#define BASS_DEVICE_8BITS 1
#define BASS_DEVICE_MONO 2
#define BASS_DEVICE_3D 4
#define BASS_DEVICE_LATENCY 256
#define BASS_DEVICE_CPSPEAKERS 1024
#define BASS_DEVICE_SPEAKERS 2048
#define BASS_DEVICE_NOSPEAKER 4096
#define BASS_OBJECT_DS 1
#define BASS_OBJECT_DS3DL 2

type BASS_DEVICEINFO
    name as zstring ptr
    driver as zstring ptr
    flags as DWORD
end type

#define BASS_DEVICE_ENABLED 1
#define BASS_DEVICE_DEFAULT 2
#define BASS_DEVICE_INIT 4

type BASS_INFO
    flags as DWORD
    hwsize as DWORD
    hwfree as DWORD
    freesam as DWORD
    free3d as DWORD
    minrate as DWORD
    maxrate as DWORD
    eax as BOOL
    minbuf as DWORD
    dsver as DWORD
    latency as DWORD
    initflags as DWORD
    speakers as DWORD
    freq as DWORD
end type

#define DSCAPS_CONTINUOUSRATE &h00000010
#define DSCAPS_EMULDRIVER &h00000020
#define DSCAPS_CERTIFIED &h00000040
#define DSCAPS_SECONDARYMONO &h00000100
#define DSCAPS_SECONDARYSTEREO &h00000200
#define DSCAPS_SECONDARY8BIT &h00000400
#define DSCAPS_SECONDARY16BIT &h00000800

type BASS_RECORDINFO
    flags as DWORD
    formats as DWORD
    inputs as DWORD
    singlein as BOOL
    freq as DWORD
end type

#define DSCCAPS_EMULDRIVER &h00000020
#define DSCCAPS_CERTIFIED &h00000040
#define WAVE_FORMAT_1M08 &h00000001
#define WAVE_FORMAT_1S08 &h00000002
#define WAVE_FORMAT_1M16 &h00000004
#define WAVE_FORMAT_1S16 &h00000008
#define WAVE_FORMAT_2M08 &h00000010
#define WAVE_FORMAT_2S08 &h00000020
#define WAVE_FORMAT_2M16 &h00000040
#define WAVE_FORMAT_2S16 &h00000080
#define WAVE_FORMAT_4M08 &h00000100
#define WAVE_FORMAT_4S08 &h00000200
#define WAVE_FORMAT_4M16 &h00000400
#define WAVE_FORMAT_4S16 &h00000800

type BASS_SAMPLE
    freq as DWORD
    volume as single
    pan as single
    flags as DWORD
    length as DWORD
    max as DWORD
    origres as DWORD
    chans as DWORD
    mingap as DWORD
    mode3d as DWORD
    mindist as single
    maxdist as single
    iangle as DWORD
    oangle as DWORD
    outvol as single
    vam as DWORD
    priority as DWORD
end type

#define BASS_SAMPLE_8BITS 1
#define BASS_SAMPLE_FLOAT 256
#define BASS_SAMPLE_MONO 2
#define BASS_SAMPLE_LOOP 4
#define BASS_SAMPLE_3D 8
#define BASS_SAMPLE_SOFTWARE 16
#define BASS_SAMPLE_MUTEMAX 32
#define BASS_SAMPLE_VAM 64
#define BASS_SAMPLE_FX 128
#define BASS_SAMPLE_OVER_VOL &h10000
#define BASS_SAMPLE_OVER_POS &h20000
#define BASS_SAMPLE_OVER_DIST &h30000
#define BASS_STREAM_PRESCAN &h20000
#define BASS_MP3_SETPOS &h20000
#define BASS_STREAM_AUTOFREE &h40000
#define BASS_STREAM_RESTRATE &h80000
#define BASS_STREAM_BLOCK &h100000
#define BASS_STREAM_DECODE &h200000
#define BASS_STREAM_STATUS &h800000
#define BASS_MUSIC_FLOAT 256
#define BASS_MUSIC_MONO 2
#define BASS_MUSIC_LOOP 4
#define BASS_MUSIC_3D 8
#define BASS_MUSIC_FX 128
#define BASS_MUSIC_AUTOFREE &h40000
#define BASS_MUSIC_DECODE &h200000
#define BASS_MUSIC_PRESCAN &h20000
#define BASS_MUSIC_CALCLEN &h20000
#define BASS_MUSIC_RAMP &h200
#define BASS_MUSIC_RAMPS &h400
#define BASS_MUSIC_SURROUND &h800
#define BASS_MUSIC_SURROUND2 &h1000
#define BASS_MUSIC_FT2MOD &h2000
#define BASS_MUSIC_PT1MOD &h4000
#define BASS_MUSIC_NONINTER &h10000
#define BASS_MUSIC_SINCINTER &h800000
#define BASS_MUSIC_POSRESET &h8000
#define BASS_MUSIC_POSRESETEX &h400000
#define BASS_MUSIC_STOPBACK &h80000
#define BASS_MUSIC_NOSAMPLE &h100000
#define BASS_SPEAKER_FRONT &h1000000
#define BASS_SPEAKER_REAR &h2000000
#define BASS_SPEAKER_CENLFE &h3000000
#define BASS_SPEAKER_REAR2 &h4000000
#define BASS_SPEAKER_LEFT &h10000000
#define BASS_SPEAKER_RIGHT &h20000000
#define BASS_SPEAKER_FRONTLEFT &h1000000 or &h10000000
#define BASS_SPEAKER_FRONTRIGHT &h1000000 or &h20000000
#define BASS_SPEAKER_REARLEFT &h2000000 or &h10000000
#define BASS_SPEAKER_REARRIGHT &h2000000 or &h20000000
#define BASS_SPEAKER_CENTER &h3000000 or &h10000000
#define BASS_SPEAKER_LFE &h3000000 or &h20000000
#define BASS_SPEAKER_REAR2LEFT &h4000000 or &h10000000
#define BASS_SPEAKER_REAR2RIGHT &h4000000 or &h20000000
#define BASS_UNICODE &h80000000
#define BASS_RECORD_PAUSE &h8000
#define BASS_VAM_HARDWARE 1
#define BASS_VAM_SOFTWARE 2
#define BASS_VAM_TERM_TIME 4
#define BASS_VAM_TERM_DIST 8
#define BASS_VAM_TERM_PRIO 16

type BASS_CHANNELINFO
    freq as DWORD
    chans as DWORD
    flags as DWORD
    ctype as DWORD
    origres as DWORD
    plugin as HPLUGIN
    sample as HSAMPLE
    filename as zstring ptr
end type

#define BASS_CTYPE_SAMPLE 1
#define BASS_CTYPE_RECORD 2
#define BASS_CTYPE_STREAM &h10000
#define BASS_CTYPE_STREAM_OGG &h10002
#define BASS_CTYPE_STREAM_MP1 &h10003
#define BASS_CTYPE_STREAM_MP2 &h10004
#define BASS_CTYPE_STREAM_MP3 &h10005
#define BASS_CTYPE_STREAM_AIFF &h10006
#define BASS_CTYPE_STREAM_CA &h10007
#define BASS_CTYPE_STREAM_MF &h10008
#define BASS_CTYPE_STREAM_WAV &h40000
#define BASS_CTYPE_STREAM_WAV_PCM &h50001
#define BASS_CTYPE_STREAM_WAV_FLOAT &h50003
#define BASS_CTYPE_MUSIC_MOD &h20000
#define BASS_CTYPE_MUSIC_MTM &h20001
#define BASS_CTYPE_MUSIC_S3M &h20002
#define BASS_CTYPE_MUSIC_XM &h20003
#define BASS_CTYPE_MUSIC_IT &h20004
#define BASS_CTYPE_MUSIC_MO3 &h00100

type BASS_PLUGINFORM
    ctype as DWORD
    name as zstring ptr
    exts as zstring ptr
end type

type BASS_PLUGININFO
    version as DWORD
    formatc as DWORD
    formats as BASS_PLUGINFORM ptr
end type

type BASS_3DVECTOR
    x as single
    y as single
    z as single
end type

'type BASS_3DVECTOR as Any

#define BASS_3DMODE_NORMAL 0
#define BASS_3DMODE_RELATIVE 1
#define BASS_3DMODE_OFF 2
#define BASS_3DALG_DEFAULT 0
#define BASS_3DALG_OFF 1
#define BASS_3DALG_FULL 2
#define BASS_3DALG_LIGHT 3

enum
    EAX_ENVIRONMENT_GENERIC
    EAX_ENVIRONMENT_PADDEDCELL
    EAX_ENVIRONMENT_ROOM
    EAX_ENVIRONMENT_BATHROOM
    EAX_ENVIRONMENT_LIVINGROOM
    EAX_ENVIRONMENT_STONEROOM
    EAX_ENVIRONMENT_AUDITORIUM
    EAX_ENVIRONMENT_CONCERTHALL
    EAX_ENVIRONMENT_CAVE
    EAX_ENVIRONMENT_ARENA
    EAX_ENVIRONMENT_HANGAR
    EAX_ENVIRONMENT_CARPETEDHALLWAY
    EAX_ENVIRONMENT_HALLWAY
    EAX_ENVIRONMENT_STONECORRIDOR
    EAX_ENVIRONMENT_ALLEY
    EAX_ENVIRONMENT_FOREST
    EAX_ENVIRONMENT_CITY
    EAX_ENVIRONMENT_MOUNTAINS
    EAX_ENVIRONMENT_QUARRY
    EAX_ENVIRONMENT_PLAIN
    EAX_ENVIRONMENT_PARKINGLOT
    EAX_ENVIRONMENT_SEWERPIPE
    EAX_ENVIRONMENT_UNDERWATER
    EAX_ENVIRONMENT_DRUGGED
    EAX_ENVIRONMENT_DIZZY
    EAX_ENVIRONMENT_PSYCHOTIC
    EAX_ENVIRONMENT_COUNT
end enum

#define EAX_PRESET_GENERIC         EAX_ENVIRONMENT_GENERIC,0.5f,1.493f,0.5f
#define EAX_PRESET_PADDEDCELL      EAX_ENVIRONMENT_PADDEDCELL,0.25f,0.1f,0.0f
#define EAX_PRESET_ROOM            EAX_ENVIRONMENT_ROOM,0.417f,0.4f,0.666f
#define EAX_PRESET_BATHROOM        EAX_ENVIRONMENT_BATHROOM,0.653f,1.499f,0.166f
#define EAX_PRESET_LIVINGROOM      EAX_ENVIRONMENT_LIVINGROOM,0.208f,0.478f,0.0f
#define EAX_PRESET_STONEROOM       EAX_ENVIRONMENT_STONEROOM,0.5f,2.309f,0.888f
#define EAX_PRESET_AUDITORIUM      EAX_ENVIRONMENT_AUDITORIUM,0.403f,4.279f,0.5f
#define EAX_PRESET_CONCERTHALL     EAX_ENVIRONMENT_CONCERTHALL,0.5f,3.961f,0.5f
#define EAX_PRESET_CAVE            EAX_ENVIRONMENT_CAVE,0.5f,2.886f,1.304f
#define EAX_PRESET_ARENA           EAX_ENVIRONMENT_ARENA,0.361f,7.284f,0.332f
#define EAX_PRESET_HANGAR          EAX_ENVIRONMENT_HANGAR,0.5f,10.0f,0.3f
#define EAX_PRESET_CARPETEDHALLWAY EAX_ENVIRONMENT_CARPETEDHALLWAY,0.153f,0.259f,2.0f
#define EAX_PRESET_HALLWAY         EAX_ENVIRONMENT_HALLWAY,0.361f,1.493f,0.0f
#define EAX_PRESET_STONECORRIDOR   EAX_ENVIRONMENT_STONECORRIDOR,0.444f,2.697f,0.638f
#define EAX_PRESET_ALLEY           EAX_ENVIRONMENT_ALLEY,0.25f,1.752f,0.776f
#define EAX_PRESET_FOREST          EAX_ENVIRONMENT_FOREST,0.111f,3.145f,0.472f
#define EAX_PRESET_CITY            EAX_ENVIRONMENT_CITY,0.111f,2.767f,0.224f
#define EAX_PRESET_MOUNTAINS       EAX_ENVIRONMENT_MOUNTAINS,0.194f,7.841f,0.472f
#define EAX_PRESET_QUARRY          EAX_ENVIRONMENT_QUARRY,1.0f,1.499f,0.5f
#define EAX_PRESET_PLAIN           EAX_ENVIRONMENT_PLAIN,0.097f,2.767f,0.224f
#define EAX_PRESET_PARKINGLOT      EAX_ENVIRONMENT_PARKINGLOT,0.208f,1.652f,1.5f
#define EAX_PRESET_SEWERPIPE       EAX_ENVIRONMENT_SEWERPIPE,0.652f,2.886f,0.25f
#define EAX_PRESET_UNDERWATER      EAX_ENVIRONMENT_UNDERWATER,1.0f,1.499f,0.0f
#define EAX_PRESET_DRUGGED         EAX_ENVIRONMENT_DRUGGED,0.875f,8.392f,1.388f
#define EAX_PRESET_DIZZY           EAX_ENVIRONMENT_DIZZY,0.139f,17.234f,0.666f
#define EAX_PRESET_PSYCHOTIC       EAX_ENVIRONMENT_PSYCHOTIC,0.486f,7.563f,0.806f

type STREAMPROC as function stdcall (byval as HSTREAM, byval as any ptr, byval as DWORD, byval as any ptr) as DWORD

#define BASS_STREAMPROC_END &h80000000

#define STREAMPROC_DUMMY        Cast(STREAMPROC Ptr, 0)
#define STREAMPROC_PUSH         Cast(STREAMPROC Ptr, -1)

#define STREAMFILE_NOBUFFER 0
#define STREAMFILE_BUFFER 1
#define STREAMFILE_BUFFERPUSH 2

type FILECLOSEPROC as sub stdcall (byval as any ptr)
type FILELENPROC as function stdcall (byval as any ptr) as QWORD
type FILEREADPROC as function stdcall (byval as any ptr, byval as DWORD, byval as any ptr) as DWORD
type FILESEEKPROC as function stdcall (byval as QWORD, byval as any ptr) as BOOL

type BASS_FILEPROCS
    close as FILECLOSEPROC ptr
    length as FILELENPROC ptr
    read as FILEREADPROC ptr
    seek as FILESEEKPROC ptr
end type

#define BASS_FILEDATA_END 0
#define BASS_FILEPOS_CURRENT 0
#define BASS_FILEPOS_DECODE 0
#define BASS_FILEPOS_DOWNLOAD 1
#define BASS_FILEPOS_END 2
#define BASS_FILEPOS_START 3
#define BASS_FILEPOS_CONNECTED 4
#define BASS_FILEPOS_BUFFER 5
#define BASS_FILEPOS_SOCKET 6

type DOWNLOADPROC as sub stdcall (byval as const any ptr, byval as DWORD, byval as any ptr)

#define BASS_SYNC_POS 0
#define BASS_SYNC_END 2
#define BASS_SYNC_META 4
#define BASS_SYNC_SLIDE 5
#define BASS_SYNC_STALL 6
#define BASS_SYNC_DOWNLOAD 7
#define BASS_SYNC_FREE 8
#define BASS_SYNC_SETPOS 11
#define BASS_SYNC_MUSICPOS 10
#define BASS_SYNC_MUSICINST 1
#define BASS_SYNC_MUSICFX 3
#define BASS_SYNC_OGG_CHANGE 12
#define BASS_SYNC_MIXTIME &h40000000
#define BASS_SYNC_ONETIME &h80000000

type SYNCPROC as sub (byval as HSYNC, byval as DWORD, byval as DWORD, byval as any ptr)
type DSPPROC as sub (byval as HDSP, byval as DWORD, byval as any ptr, byval as DWORD, byval as any ptr)
type RECORDPROC as function (byval as HRECORD, byval as const any ptr, byval as DWORD, byval as any ptr) as BOOL

#define BASS_ACTIVE_STOPPED 0
#define BASS_ACTIVE_PLAYING 1
#define BASS_ACTIVE_STALLED 2
#define BASS_ACTIVE_PAUSED 3
#define BASS_ATTRIB_FREQ 1
#define BASS_ATTRIB_VOL 2
#define BASS_ATTRIB_PAN 3
#define BASS_ATTRIB_EAXMIX 4
#define BASS_ATTRIB_NOBUFFER 5
#define BASS_ATTRIB_CPU 7
#define BASS_ATTRIB_MUSIC_AMPLIFY &h100
#define BASS_ATTRIB_MUSIC_PANSEP &h101
#define BASS_ATTRIB_MUSIC_PSCALER &h102
#define BASS_ATTRIB_MUSIC_BPM &h103
#define BASS_ATTRIB_MUSIC_SPEED &h104
#define BASS_ATTRIB_MUSIC_VOL_GLOBAL &h105
#define BASS_ATTRIB_MUSIC_VOL_CHAN &h200
#define BASS_ATTRIB_MUSIC_VOL_INST &h300
#define BASS_DATA_AVAILABLE 0
#define BASS_DATA_FLOAT &h40000000
#define BASS_DATA_FFT256 &h80000000
#define BASS_DATA_FFT512 &h80000001
#define BASS_DATA_FFT1024 &h80000002
#define BASS_DATA_FFT2048 &h80000003
#define BASS_DATA_FFT4096 &h80000004
#define BASS_DATA_FFT8192 &h80000005
#define BASS_DATA_FFT16384 &h80000006
#define BASS_DATA_FFT_INDIVIDUAL &h10
#define BASS_DATA_FFT_NOWINDOW &h20
#define BASS_DATA_FFT_REMOVEDC &h40
#define BASS_TAG_ID3 0
#define BASS_TAG_ID3V2 1
#define BASS_TAG_OGG 2
#define BASS_TAG_HTTP 3
#define BASS_TAG_ICY 4
#define BASS_TAG_META 5
#define BASS_TAG_APE 6
#define BASS_TAG_MP4 7
#define BASS_TAG_VENDOR 9
#define BASS_TAG_LYRICS3 10
#define BASS_TAG_CA_CODEC 11
#define BASS_TAG_MF 13
#define BASS_TAG_WAVEFORMAT 14
#define BASS_TAG_RIFF_INFO &h100
#define BASS_TAG_RIFF_BEXT &h101
#define BASS_TAG_RIFF_CART &h102
#define BASS_TAG_RIFF_DISP &h103
#define BASS_TAG_APE_BINARY &h1000
#define BASS_TAG_MUSIC_NAME &h10000
#define BASS_TAG_MUSIC_MESSAGE &h10001
#define BASS_TAG_MUSIC_ORDERS &h10002
#define BASS_TAG_MUSIC_INST &h10100
#define BASS_TAG_MUSIC_SAMPLE &h10300

type TAG_ID3
    id as zstring * 3
    title as zstring * 30
    artist as zstring * 30
    album as zstring * 30
    year as zstring * 4
    comment as zstring * 30
    genre as BYTE
end type

type TAG_APE_BINARY
    key as zstring ptr
    data as any ptr
    length as DWORD
end type

type TAG_BEXT
    Description as zstring * 256
    Originator as zstring * 32
    OriginatorReference as zstring * 32
    OriginationDate as zstring * 10
    OriginationTime as zstring * 8
    TimeReference as QWORD
    Version as WORD
    UMID(0 to 64-1) as BYTE
    Reserved(0 to 190-1) as BYTE
    CodingHistory as zstring * 1
end type

type TAG_CART_TIMER
    dwUsage as DWORD
    dwValue as DWORD
end type

type TAG_CART
    Version as zstring * 4
    Title as zstring * 64
    Artist as zstring * 64
    CutID as zstring * 64
    ClientID as zstring * 64
    Category as zstring * 64
    Classification as zstring * 64
    OutCue as zstring * 64
    StartDate as zstring * 10
    StartTime as zstring * 8
    EndDate as zstring * 10
    EndTime as zstring * 8
    ProducerAppID as zstring * 64
    ProducerAppVersion as zstring * 64
    UserDef as zstring * 64
    dwLevelReference as DWORD
    PostTimer(0 to 8-1) as TAG_CART_TIMER
    Reserved as zstring * 276
    URL as zstring * 1024
    TagText as zstring * 1
end type

type TAG_CA_CODEC
    ftype as DWORD
    atype as DWORD
    name as zstring ptr
end type

#define BASS_POS_BYTE 0
#define BASS_POS_MUSIC_ORDER 1
#define BASS_POS_DECODE &h10000000
#define BASS_POS_DECODETO &h20000000
#define BASS_INPUT_OFF &h10000
#define BASS_INPUT_ON &h20000
#define BASS_INPUT_TYPE_MASK &hff000000
#define BASS_INPUT_TYPE_UNDEF &h00000000
#define BASS_INPUT_TYPE_DIGITAL &h01000000
#define BASS_INPUT_TYPE_LINE &h02000000
#define BASS_INPUT_TYPE_MIC &h03000000
#define BASS_INPUT_TYPE_SYNTH &h04000000
#define BASS_INPUT_TYPE_CD &h05000000
#define BASS_INPUT_TYPE_PHONE &h06000000
#define BASS_INPUT_TYPE_SPEAKER &h07000000
#define BASS_INPUT_TYPE_WAVE &h08000000
#define BASS_INPUT_TYPE_AUX &h09000000
#define BASS_INPUT_TYPE_ANALOG &h0a000000

enum
    BASS_FX_DX8_CHORUS
    BASS_FX_DX8_COMPRESSOR
    BASS_FX_DX8_DISTORTION
    BASS_FX_DX8_ECHO
    BASS_FX_DX8_FLANGER
    BASS_FX_DX8_GARGLE
    BASS_FX_DX8_I3DL2REVERB
    BASS_FX_DX8_PARAMEQ
    BASS_FX_DX8_REVERB
end enum

type BASS_DX8_CHORUS
    fWetDryMix as single
    fDepth as single
    fFeedback as single
    fFrequency as single
    lWaveform as DWORD
    fDelay as single
    lPhase as DWORD
end type

type BASS_DX8_COMPRESSOR
    fGain as single
    fAttack as single
    fRelease as single
    fThreshold as single
    fRatio as single
    fPredelay as single
end type

type BASS_DX8_DISTORTION
    fGain as single
    fEdge as single
    fPostEQCenterFrequency as single
    fPostEQBandwidth as single
    fPreLowpassCutoff as single
end type

type BASS_DX8_ECHO
    fWetDryMix as single
    fFeedback as single
    fLeftDelay as single
    fRightDelay as single
    lPanDelay as BOOL
end type

type BASS_DX8_FLANGER
    fWetDryMix as single
    fDepth as single
    fFeedback as single
    fFrequency as single
    lWaveform as DWORD
    fDelay as single
    lPhase as DWORD
end type

type BASS_DX8_GARGLE
    dwRateHz as DWORD
    dwWaveShape as DWORD
end type

type BASS_DX8_I3DL2REVERB
    lRoom as integer
    lRoomHF as integer
    flRoomRolloffFactor as single
    flDecayTime as single
    flDecayHFRatio as single
    lReflections as integer
    flReflectionsDelay as single
    lReverb as integer
    flReverbDelay as single
    flDiffusion as single
    flDensity as single
    flHFReference as single
end type

type BASS_DX8_PARAMEQ
    fCenter as single
    fBandwidth as single
    fGain as single
end type

type BASS_DX8_REVERB
    fInGain as single
    fReverbMix as single
    fReverbTime as single
    fHighFreqRTRatio as single
end type

#define BASS_DX8_PHASE_NEG_180 0
#define BASS_DX8_PHASE_NEG_90 1
#define BASS_DX8_PHASE_ZERO 2
#define BASS_DX8_PHASE_90 3
#define BASS_DX8_PHASE_180 4

declare function BASS_SetConfig (byval option as DWORD, byval value as DWORD) as BOOL
declare function BASS_GetConfig (byval option as DWORD) as DWORD
declare function BASS_SetConfigPtr (byval option as DWORD, byval value as any ptr) as BOOL
declare function BASS_GetConfigPtr (byval option as DWORD) as any ptr
declare function BASS_GetVersion () as DWORD
declare function BASS_ErrorGetCode () as integer
declare function BASS_GetDeviceInfo (byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL
declare function BASS_Init (byval device as integer, byval freq as DWORD, byval flags as DWORD, byval win as any ptr, byval dsguid as any ptr) as BOOL
declare function BASS_SetDevice (byval device as DWORD) as BOOL
declare function BASS_GetDevice () as DWORD
declare function BASS_Free () as BOOL
declare function BASS_GetInfo (byval info as BASS_INFO ptr) as BOOL
declare function BASS_Update (byval length as DWORD) as BOOL
declare function BASS_GetCPU () as single
declare function BASS_Start () as BOOL
declare function BASS_Stop () as BOOL
declare function BASS_Pause () as BOOL
declare function BASS_SetVolume (byval volume as single) as BOOL
declare function BASS_GetVolume () as single
declare function BASS_PluginLoad (byval file as zstring ptr, byval flags as DWORD) as HPLUGIN
declare function BASS_PluginFree (byval handle as HPLUGIN) as BOOL
declare function BASS_PluginGetInfo (byval handle as HPLUGIN) as BASS_PLUGININFO ptr
declare function BASS_Set3DFactors (byval distf as single, byval rollf as single, byval doppf as single) as BOOL
declare function BASS_Get3DFactors (byval distf as single ptr, byval rollf as single ptr, byval doppf as single ptr) as BOOL
declare function BASS_Set3DPosition (byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
declare function BASS_Get3DPosition (byval pos as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr, byval front as BASS_3DVECTOR ptr, byval top as BASS_3DVECTOR ptr) as BOOL
declare sub BASS_Apply3D ()
declare function BASS_MusicLoad (byval mem as BOOL, byval file as any ptr, byval offset as QWORD, byval length as DWORD, byval flags as DWORD, byval freq as DWORD) as HMUSIC
declare function BASS_MusicFree (byval handle as HMUSIC) as BOOL
declare function BASS_SampleLoad (byval mem as BOOL, byval file as any ptr, byval offset as QWORD, byval length as DWORD, byval max as DWORD, byval flags as DWORD) as HSAMPLE
declare function BASS_SampleCreate (byval length as DWORD, byval freq as DWORD, byval chans as DWORD, byval max as DWORD, byval flags as DWORD) as HSAMPLE
declare function BASS_SampleFree (byval handle as HSAMPLE) as BOOL
declare function BASS_SampleSetData (byval handle as HSAMPLE, byval buffer as any ptr) as BOOL
declare function BASS_SampleGetData (byval handle as HSAMPLE, byval buffer as any ptr) as BOOL
declare function BASS_SampleGetInfo (byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleSetInfo (byval handle as HSAMPLE, byval info as BASS_SAMPLE ptr) as BOOL
declare function BASS_SampleGetChannel (byval handle as HSAMPLE, byval onlynew as BOOL) as HCHANNEL
declare function BASS_SampleGetChannels (byval handle as HSAMPLE, byval channels as HCHANNEL ptr) as DWORD
declare function BASS_SampleStop (byval handle as HSAMPLE) as BOOL
declare function BASS_StreamCreate (byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as STREAMPROC ptr, byval user as any ptr) as HSTREAM
declare function BASS_StreamCreateFile (byval mem as BOOL, byval file as any ptr, byval offset as QWORD, byval length as QWORD, byval flags as DWORD) as HSTREAM
declare function BASS_StreamCreateURL (byval url as zstring ptr, byval offset as DWORD, byval flags as DWORD, byval proc as DOWNLOADPROC ptr, byval user as any ptr) as HSTREAM
declare function BASS_StreamCreateFileUser (byval system as DWORD, byval flags as DWORD, byval proc as BASS_FILEPROCS ptr, byval user as any ptr) as HSTREAM
declare function BASS_StreamFree (byval handle as HSTREAM) as BOOL
declare function BASS_StreamGetFilePosition (byval handle as HSTREAM, byval mode as DWORD) as QWORD
declare function BASS_StreamPutData (byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASS_StreamPutFileData (byval handle as HSTREAM, byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASS_RecordGetDeviceInfo (byval device as DWORD, byval info as BASS_DEVICEINFO ptr) as BOOL
declare function BASS_RecordInit (byval device as integer) as BOOL
declare function BASS_RecordSetDevice (byval device as DWORD) as BOOL
declare function BASS_RecordGetDevice () as DWORD
declare function BASS_RecordFree () as BOOL
declare function BASS_RecordGetInfo (byval info as BASS_RECORDINFO ptr) as BOOL
declare function BASS_RecordGetInputName (byval input as integer) as zstring ptr
declare function BASS_RecordSetInput (byval input as integer, byval flags as DWORD, byval volume as single) as BOOL
declare function BASS_RecordGetInput (byval input as integer, byval volume as single ptr) as DWORD
declare function BASS_RecordStart (byval freq as DWORD, byval chans as DWORD, byval flags as DWORD, byval proc as RECORDPROC ptr, byval user as any ptr) as HRECORD
declare function BASS_ChannelBytes2Seconds (byval handle as DWORD, byval pos as QWORD) as double
declare function BASS_ChannelSeconds2Bytes (byval handle as DWORD, byval pos as double) as QWORD
declare function BASS_ChannelGetDevice (byval handle as DWORD) as DWORD
declare function BASS_ChannelSetDevice (byval handle as DWORD, byval device as DWORD) as BOOL
declare function BASS_ChannelIsActive (byval handle as DWORD) as DWORD
declare function BASS_ChannelGetInfo (byval handle as DWORD, byval info as BASS_CHANNELINFO ptr) as BOOL
declare function BASS_ChannelGetTags (byval handle as DWORD, byval tags as DWORD) as zstring ptr
declare function BASS_ChannelFlags (byval handle as DWORD, byval flags as DWORD, byval mask as DWORD) as DWORD
declare function BASS_ChannelUpdate (byval handle as DWORD, byval length as DWORD) as BOOL
declare function BASS_ChannelLock (byval handle as DWORD, byval lock as BOOL) as BOOL
declare function BASS_ChannelPlay (byval handle as DWORD, byval restart as BOOL) as BOOL
declare function BASS_ChannelStop (byval handle as DWORD) as BOOL
declare function BASS_ChannelPause (byval handle as DWORD) as BOOL
declare function BASS_ChannelSetAttribute (byval handle as DWORD, byval attrib as DWORD, byval value as single) as BOOL
declare function BASS_ChannelGetAttribute (byval handle as DWORD, byval attrib as DWORD, byval value as single ptr) as BOOL
declare function BASS_ChannelSlideAttribute (byval handle as DWORD, byval attrib as DWORD, byval value as single, byval time as DWORD) as BOOL
declare function BASS_ChannelIsSliding (byval handle as DWORD, byval attrib as DWORD) as BOOL
declare function BASS_ChannelSet3DAttributes (byval handle as DWORD, byval mode as integer, byval min as single, byval max as single, byval iangle as integer, byval oangle as integer, byval outvol as single) as BOOL
declare function BASS_ChannelGet3DAttributes (byval handle as DWORD, byval mode as DWORD ptr, byval min as single ptr, byval max as single ptr, byval iangle as DWORD ptr, byval oangle as DWORD ptr, byval outvol as single ptr) as BOOL
declare function BASS_ChannelSet3DPosition (byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGet3DPosition (byval handle as DWORD, byval pos as BASS_3DVECTOR ptr, byval orient as BASS_3DVECTOR ptr, byval vel as BASS_3DVECTOR ptr) as BOOL
declare function BASS_ChannelGetLength (byval handle as DWORD, byval mode as DWORD) as QWORD
declare function BASS_ChannelSetPosition (byval handle as DWORD, byval pos as QWORD, byval mode as DWORD) as BOOL
declare function BASS_ChannelGetPosition (byval handle as DWORD, byval mode as DWORD) as QWORD
declare function BASS_ChannelGetLevel (byval handle as DWORD) as DWORD
declare function BASS_ChannelGetData (byval handle as DWORD, byval buffer as any ptr, byval length as DWORD) as DWORD
declare function BASS_ChannelSetSync (byval handle as DWORD, byval type as DWORD, byval param as QWORD, byval proc as SYNCPROC ptr, byval user as any ptr) as HSYNC
declare function BASS_ChannelRemoveSync (byval handle as DWORD, byval sync as HSYNC) as BOOL
declare function BASS_ChannelSetDSP (byval handle as DWORD, byval proc as DSPPROC ptr, byval user as any ptr, byval priority as integer) as HDSP
declare function BASS_ChannelRemoveDSP (byval handle as DWORD, byval dsp as HDSP) as BOOL
declare function BASS_ChannelSetLink (byval handle as DWORD, byval chan as DWORD) as BOOL
declare function BASS_ChannelRemoveLink (byval handle as DWORD, byval chan as DWORD) as BOOL
declare function BASS_ChannelSetFX (byval handle as DWORD, byval type as DWORD, byval priority as integer) as HFX
declare function BASS_ChannelRemoveFX (byval handle as DWORD, byval fx as HFX) as BOOL
declare function BASS_FXSetParameters (byval handle as HFX, byval params as any ptr) as BOOL
declare function BASS_FXGetParameters (byval handle as HFX, byval params as any ptr) as BOOL
declare function BASS_FXReset (byval handle as HFX) as BOOL

end extern

#endif
