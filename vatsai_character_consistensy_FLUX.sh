#!/bin/bash

source /venv/main/bin/activate
COMFYUI_DIR=${WORKSPACE}/ComfyUI

# Packages are installed after nodes so we can fix them...

APT_PACKAGES=(
    #"package-1"
    #"package-2"
)

PIP_PACKAGES=(
    #"package-1"
    #"package-2"
)

NODES=(
    #"https://github.com/ltdrdata/ComfyUI-Manager"
    #"https://github.com/cubiq/ComfyUI_essentials"

    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/cubiq/ComfyUI_InstantID"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
)

WORKFLOWS=(
)


CIVITAI_CHECKPOINT_MODELS=(
)

CHECKPOINT_MODELS=(
)

IPADAPTER=(
)

INSIGHTFACE=(
)

UNET_MODELS=(
    # "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
)

LORA_MODELS=(
)

VAE_MODELS=(
    # "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors"
)

ESRGAN_MODELS=(
)

CONTROLNET_MODELS=(
    "https://huggingface.co/Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro/resolve/main/diffusion_pytorch_model.safetensors"
)

CLIP=(
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"
    # "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
)

CLIP_VISION=(
)

ULTRALYTICS=(
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

UPSCALE=(
    "https://huggingface.co/skbhadra/ClearRealityV1/resolve/main/4x-ClearRealityV1.pth"
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
        "${COMFYUI_DIR}/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
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
        "${WORKSPACE}/models/ultralytics/bbox" \
        "${ULTRALYTICS[@]}"
    provisioning_get_files \
        "${WORKSPACE}/models/upscale" \
        "${UPSCALE[@]}"
    provisioning_get_files \
        "${COMFYUI_DIR}/models/insightface" \
        "${INSIGHTFACE[@]}"
        
        
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


# function provisioning_get_files() {
#     if [[ -z $2 ]]; then return 1; fi
    
#     dir="$1"
#     mkdir -p "$dir"
#     shift
#     arr=("$@")
#     printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
#     for url in "${arr[@]}"; do
#         printf "Downloading: %s\n" "${url}"
#         provisioning_download "${url}" "${dir}"
#         printf "\n"
#     done
# }

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

# 4x-ClearRealityV1 ==>   https://huggingface.co/skbhadra/ClearRealityV1/resolve/main/4x-ClearRealityV1.pth
# FLUX.1-dev-ControlNet-Union-Pro --> https://huggingface.co/Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro/resolve/main/diffusion_pytorch_model.safetensors

# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
