#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    "insightface"
    "onnxruntime-gpu"
)

NODES=(
    # Core utilities
    "https://github.com/ltdrdata/ComfyUI-Manager"
    "https://github.com/cubiq/ComfyUI_essentials"

    # Character identity — primary stack
    "https://github.com/jax-explorer/ComfyUI-InstantCharacter"    # NEW: full-body character consistency (Tencent, Apr 2025)
    "https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced"       # PuLID-Flux-Enhanced (PulidEvaClipLoader, ApplyPulidFlux etc.)
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"               # InsightFace face analysis (required by PuLID)

    # ControlNet & preprocessors
    "https://github.com/Fannovel16/comfyui_controlnet_aux"

    # Face detailer / adetailer pass
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"

    # LoRA training inside ComfyUI
    "https://github.com/kijai/ComfyUI-FluxTrainer"

    # Legacy / kept for reference — SDXL only, not used in FLUX workflows
    # "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    # "https://github.com/cubiq/ComfyUI_InstantID"               # SDXL only — no FLUX support as of Apr 2026
    # "https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced"  # Formally discontinued by author
    # "https://github.com/lldacing/ComfyUI_PuLID_Flux_ll"
    # "https://github.com/alessandrozonta/ComfyUI-OpenPose"
)

WORKFLOWS=(
)


CIVITAI_CHECKPOINT_MODELS=(
     #"https://civitai.com/api/download/models/2805234"
)

CHECKPOINT_MODELS=(
    # DreamShaper removed — SDXL checkpoint not needed for FLUX-only workflow
    # "https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/DreamShaper_8_pruned.safetensors"
)

IPADAPTER=(
    # SDXL FaceID adapters removed — incompatible with FLUX
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl.bin"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl.bin"

    # InstantCharacter IP-Adapter — NEW, primary character consistency (Tencent + InstantX, Apr 2025, 5.59 GB)
    "https://huggingface.co/tencent/InstantCharacter/resolve/main/instantcharacter_ip-adapter.bin"
)

IPADAPTER_FLUX=(
    # XLabs FLUX IP-Adapter v2 — aesthetic/style guidance for FLUX (Apache 2.0)
    "https://huggingface.co/XLabs-AI/flux-ip-adapter-v2/resolve/main/ip_adapter.safetensors"

    # InstantX FLUX IP-Adapter — alternative, strong semantic understanding (non-commercial)
    # "https://huggingface.co/InstantX/FLUX.1-dev-IP-Adapter/resolve/main/ip-adapter.bin"
)

INSIGHTFACE=(
    # buffalo_l — required by PuLID
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/1k3d68.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/2d106det.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/det_10g.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/genderage.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/w600k_r50.onnx"
)

INSIGHTFACE2=(
    # antelopev2 — required by InstantCharacter
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/1k3d68.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/2d106det.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/genderage.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/glintr100.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/scrfd_10g_bnkps.onnx"
)

UNET_MODELS=(
    # FLUX.1-Krea-dev fp8 — 11.9 GB, runs on 24 GB VRAM, minimal quality loss vs bf16
    # NOTE: requires HF account + licence agreement at huggingface.co/black-forest-labs/FLUX.1-Krea-dev
    #"https://huggingface.co/Comfy-Org/FLUX.1-Krea-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-krea-dev_fp8_scaled.safetensors"

    # FLUX.1-Krea-dev bf16 full — 23.8 GB, best quality, needs 24+ GB VRAM with offloading
    "https://huggingface.co/black-forest-labs/FLUX.1-Krea-dev/resolve/main/flux1-krea-dev.safetensors"

    # uncensored for flux - TRIAL
    #"https://huggingface.co/lodestones/Chroma1-HD/resolve/main/Chroma1-HD.safetensors"
    
    # FLUX.1-dev bf16 — alternative base, better for LoRA training
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
)

LORA_MODELS=(
    # Realism stack — stack both for photorealistic skin and lighting
    "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors"
    "https://huggingface.co/strangerzonehf/Flux-Super-Realism-LoRA/resolve/main/super-realism.safetensors"
    
    # ⭐⭐⭐ Character LoRA — Kia / trigger word: kiaVV6202uxulf (PRIVATE REPO — requires HF_TOKEN)
    "https://huggingface.co/Raph007934/kia-lora-private/resolve/main/koz-BL9DLXTq4-ALx9HzQ_pytorch_lora_weights.safetensors"
    "https://huggingface.co/Raph007934/kia-lora-private/resolve/main/ATJ_Only_v0_pytorch_lora_weights.safetensors"
    # Close portrait — tightens face framing for portrait shots
   # "https://huggingface.co/dvyio/flux-lora-close-portrait/resolve/main/88e193429baa46ba89d6c6da9486268e_pytorch_lora_weights.safetensors"

    # Old SDXL FaceID LoRAs removed — incompatible with FLUX
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl_lora.safetensors"
    # "https://huggingface.co/Kijai/flux-loras-comfyui/blob/main/xlabs/xlabs_flux_realism_lora_comfui.safetensors"  # broken blob link
)

VAE_MODELS=(
    # FLUX VAE — same file works for Krea-dev and FLUX.1-dev
    "https://huggingface.co/black-forest-labs/FLUX.1-Krea-dev/resolve/main/ae.safetensors"
)


UPSCALE_MODELS=(
    # Best for portraits / skin texture
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"

    # General purpose upscalers
    "https://huggingface.co/datasets/Kizi-Art/Upscale/resolve/fa98e357882a23b8e7928957a39462fbfaee1af5/4x-UltraSharp.pth"
    "https://huggingface.co/gemasai/4x_NMKD-Superscale-SP_178000_G/resolve/main/4x_NMKD-Superscale-SP_178000_G.pth"
    "https://huggingface.co/airomix/models/resolve/959e06106e9a212f2137ac145e6a2d6919ac1d56/4x-NMKD-Superscale.pt"
)


PULID=(
    # PuLID FLUX v0.9.1 — latest official, +5% face similarity vs v0.9.0, FLUX.1-Krea-dev compatible
    "https://huggingface.co/guozinan/PuLID/resolve/main/pulid_flux_v0.9.1.safetensors"

    # PuLID Flux2 Klein v2 — community build for FLUX.2 Klein (MIT, Mar 2026) — enable if migrating to FLUX.2
    # "https://huggingface.co/Fayens/Pulid-Flux2/resolve/main/pulid_flux2_klein_v2.safetensors"
)

ULTRALYTICS=(
    # Face and hand detectors for adetailer / Impact Pack face fix pass
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

CONTROLNET_MODELS=(
    # FLUX ControlNet Union Pro — best all-in-one ControlNet for FLUX (canny, depth, pose, etc.)
    # Enable when needed — large file
    # "https://huggingface.co/Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro/resolve/main/diffusion_pytorch_model.safetensors"

    # InstantX FLUX Canny ControlNet
    # "https://huggingface.co/InstantX/FLUX.1-dev-Controlnet-Canny/resolve/main/diffusion_pytorch_model.safetensors"
)

CLIP=(
    # T5-XXL fp8 — primary text encoder for FLUX (4.89 GB)
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"

    # CLIP-L — secondary text encoder for FLUX (246 MB)
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"

    # EVA-CLIP — required by PuLID for face encoding (3.5 GB)
    "https://huggingface.co/QuanSun/EVA-CLIP/resolve/main/EVA02_CLIP_L_336_psz14_s6B.pt"
)

CLIP_VISION=(
    # CLIP-ViT-H-14 — used by IP-Adapter aesthetic layer (3.9 GB)
    "https://huggingface.co/laion/CLIP-ViT-H-14-laion2B-s32B-b79K/resolve/main/model.safetensors"
)


### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_files \
        "${COMFYUI_DIR}/models/checkpoints" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/ipadapter" \
        "${IPADAPTER[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/upscale_models" \
        "${UPSCALE_MODELS[@]}"
    provisioning_has_valid_civitai_token \
        "${COMFYUI_DIR}/models/checkpoints" \
        "${CIVITAI_CHECKPOINT_MODELS[@]}"

    provisioning_get_files \
        "${COMFYUI_DIR}/models/clip" \
        "${CLIP[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/clip_vision" \
        "${CLIP_VISION[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/insightface" \
        "${INSIGHTFACE[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/insightface/models/antelopev2" \
        "${INSIGHTFACE2[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/ultralytics/bbox" \
        "${ULTRALYTICS[@]}"
        
    provisioning_get_files \
        "${COMFYUI_DIR}/models/ipadapter-flux" \
        "${IPADAPTER_FLUX[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/pulid" \
        "${PULID[@]}"        
    provisioning_print_end
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo $APT_INSTALL ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip install --no-cache-dir ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_nodes() {
    for repo in "${NODES[@]}"; do
        dir="${repo##*/}"
        path="${COMFYUI_DIR}custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip install --no-cache-dir -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip install --no-cache-dir -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_files() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        # Check if directory is specifically for CLIP_VISION
        if [[ "$dir" == *"clip_vision"* ]]; then
             printf "Downloading and RENAMING CLIP Model\n"

            # Explicitly define the desired filename
            target_file="${dir}/CLIP-ViT-H-14-laion2B-s32B-b79K.safetensors"

            # Use wget with -O to save the file directly
            wget -qnc  --show-progress -e dotbytes="${3:-4M}" -O "$target_file" "${url}"
        else
            provisioning_download "${url}" "${dir}"
        fi
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token ]];then
        wget --header="Authorization: Bearer $auth_token" -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    else
        wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
    fi
}

function provisioning_has_valid_civitai_token() {
    # Hardcoded Civitai token
    local CIVITAI_TOKEN="8d3612baaafd4ed9db408ff955a3f87c"

    local target_directory="${1:-}"
    local model_id="${2:-}"

    # Ensure the target directory is provided
    if [[ -z "$target_directory" ]]; then
        echo "Error: Target directory is required as the first argument." >&2
        return 1
    fi

    # Ensure the model ID or name is provided
    if [[ -z "$model_id" ]]; then
        echo "Error: Model ID or name is required as the second argument." >&2
        return 1
    fi

    # Ensure the target directory exists
    mkdir -p "$target_directory"

    # Construct the URL for downloading the model
    local url="https://civitai.com/api/download/models/$model_id"
    local output_file="$target_directory/$model_id.safetensors"

    # Attempt to download the model
    echo "Downloading model ID: $model_id to directory: $target_directory"
    curl -H "Authorization: Bearer $CIVITAI_TOKEN" \
         -L -o "$output_file" \
         "$url"

    if [[ $? -eq 0 ]]; then
        echo "Model downloaded successfully: $output_file"
        return 0
    else
        echo "Error: Failed to download model with ID $model_id" >&2
        return 1
    fi
}


# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
