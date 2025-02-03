#!/bin/bash

model_path="urdu.nemo"
lang_id="ur"

model_path="ml.nemo"
lang_id="ml"

ASSETS="assets"
mkdir -p $ASSETS/{models, sample_audio}

wget -c https://objectstore.e2enetworks.net/indic-asr-public/indicConformer/ai4b_indicConformer_${lang_id}.nemo \
    -O $ASSETS/models/${model_path}

# download and load audio
MEDIA_URL="https://objectstore.e2enetworks.net/indic-asr-public/sample_audio.wav"
wget -c $MEDIA_URL -O $ASSETS/sample_audio/sample_audio.wav

# downsample, single channel
(cd $ASSETS/sample_audio && ffmpeg -i sample_audio.wav -ac 1 -ar 16000 sample_audio_infer_ready.wav -y)
