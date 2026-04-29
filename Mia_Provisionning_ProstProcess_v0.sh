#!/bin/bash
# Post-processing provisioning script — skin_polish_dd workflow only
# Much lighter than Verus_Vision_V1.sh — no PuLID, no InsightFace, no IP-Adapter
# Can run on a cheaper GPU (RTX 3090 24GB sufficient)

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

APT_PACKAGES=(
)

PIP_PACKAGES=(
    # No insightface/onnxruntime needed — PuLID not used in post-processing
)

NODES=(
    "https://github.com/ltdrdata/ComfyUI-Manager"

    # FaceDetailer + UltralyticsDetectorProvider
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"

    # UltimateSDUpscale — 2× tiled upscale pass
    "https://github.com/ssitu/ComfyUI_UltimateSDUpscale"

    # DetailDaemon — enhanced sampler for micro-detail
    "https://github.com/Jonseed/ComfyUI-Detail-Daemon"
)

UNET_MODELS=(
    # FLUX.1-Krea-dev fp8 — 11.9 GB, sufficient for img2img at low denoise
    # NOTE: requires HF_TOKEN + licence agreement at huggingface.co/black-forest-labs/FLUX.1-Krea-dev
    "https://huggingface.co/Comfy-Org/FLUX.1-Krea-dev_ComfyUI/resolve/main/split_files/diffusion_models/flux1-krea-dev_fp8_scaled.safetensors"

    # bf16 full quality — 23.8 GB, uncomment if you have 40+ GB VRAM
    # "https://huggingface.co/black-forest-labs/FLUX.1-Krea-dev/resolve/main/flux1-krea-dev.safetensors"
)

LORA_MODELS=(
    # Character LoRA — trigger word: kiaVV6202uxulf (PRIVATE REPO — requires HF_TOKEN)
    "https://huggingface.co/Raph007934/kia-lora-private/resolve/main/koz-BL9DLXTq4-ALx9HzQ_pytorch_lora_weights.safetensors"

    # Realism LoRA — skin and lighting quality
    "https://huggingface.co/strangerzonehf/Flux-Super-Realism-LoRA/resolve/main/super-realism.safetensors"
)

VAE_MODELS=(
    "https://huggingface.co/black-forest-labs/FLUX.1-Krea-dev/resolve/main/ae.safetensors"
)

CLIP=(
    # T5-XXL fp8 — primary text encoder for FLUX (4.89 GB)
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"

    # CLIP-L — secondary text encoder for FLUX (246 MB)
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
)

UPSCALE_MODELS=(
    # Portrait upscaler — used in UltimateSDUpscale 2× pass
    "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"

    # Skin texture layer — applied after 2× upscale via ImageUpscaleWithModel
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/1x-ITF-SkinDiffDetail-Lite-v1.pth"
)

ULTRALYTICS=(
    # Face detector for FaceDetailer pass
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
)


### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_nodes
    provisioning_get_pip_packages
    provisioning_get_files \
        "${COMFYUI_DIR}/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/clip" \
        "${CLIP[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/upscale_models" \
        "${UPSCALE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/ultralytics/bbox" \
        "${ULTRALYTICS[@]}"
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
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#     Post-Processing Provisioning           #\n#     skin_polish_dd workflow                #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Application will start now\n\n"
}

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

if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
