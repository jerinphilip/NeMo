#!/bin/bash

model_path="urdu.nemo"
lang_id="ur"

model_path="ml.nemo"
lang_id="ml"

wget -c https://objectstore.e2enetworks.net/indic-asr-public/indicConformer/ai4b_indicConformer_${lang_id}.nemo -O ${model_path}

# download and load audio
MEDIA_URL="https://objectstore.e2enetworks.net/indic-asr-public/sample_audio.wav"
wget -c $MEDIA_URL -O sample_audio.wav

# downsample, single channel
ffmpeg -i sample_audio.wav -ac 1 -ar 16000 sample_audio_infer_ready.wav -y
