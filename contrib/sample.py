import torch
import argparse
import soundfile as sf
import nemo.collections.asr as nemo_asr

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--model_path", type=str, default="", help="Path to model", required=True
    )
    parser.add_argument(
        "--lang_id", type=str, default="", help="Language ID", required=True
    )
    args = parser.parse_args()
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = nemo_asr.models.EncDecCTCModel.restore_from(restore_path=args.model_path)
    model.eval()  # inference mode
    model = model.to(device)  # transfer model to device

    model.cur_decoder = "ctc"
    ctc_text = model.transcribe(
        ["sample_audio_infer_ready.wav"],
        batch_size=1,
        logprobs=False,
        language_id=args.lang_id,
    )[0]
    print(ctc_text)

    model.cur_decoder = "rnnt"
    ctc_text = model.transcribe(
        ["sample_audio_infer_ready.wav"],
        batch_size=1,
        logprobs=False,
        language_id=args.lang_id,
    )[0]
    print(ctc_text)
