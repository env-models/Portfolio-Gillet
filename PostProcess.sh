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
    "https://github.com/sipie800/ComfyUI-PuLID-Flux-Enhanced"
    "https://github.com/Fannovel16/comfyui_controlnet_aux"
    "https://github.com/cubiq/ComfyUI_IPAdapter_plus"
    "https://github.com/cubiq/ComfyUI_InstantID"
    "https://github.com/cubiq/ComfyUI_FaceAnalysis"
    "https://github.com/alessandrozonta/ComfyUI-OpenPose"
    "https://github.com/lldacing/ComfyUI_PuLID_Flux_ll"
)

WORKFLOWS=(
)


CIVITAI_CHECKPOINT_MODELS=(
    # "https://civitai.com/api/download/models/1074830"
    1074830
)

CHECKPOINT_MODELS=(
    # "https://civitai.com/api/download/models/798204?type=Model&format=SafeTensor&size=full&fp=fp16"
    "https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/DreamShaper_8_pruned.safetensors"
    # "https://huggingface.co/alimama-creative/FLUX.1-dev-Controlnet-Inpainting-Beta/resolve/main/diffusion_pytorch_model.safetensors"
)

IPADAPTER=(
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15.bin"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15.binx"    
    "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-portrait_sdxl.bin"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl.bin"

    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-plus-face_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter-full-face_sd15.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15.safetensors"

    # "https://huggingface.co/h94/IP-Adapter/resolve/main/models/ip-adapter_sd15_light_v11.bin"
    "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter_sdxl_vit-h.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors"
    # "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"

)

IPADAPTER_FLUX=(
    # "https://huggingface.co/XLabs-AI/flux-ip-adapter/resolve/main/ip_adapter.safetensors"
    # "https://huggingface.co/InstantX/FLUX.1-dev-IP-Adapter/resolve/main/ip-adapter.bin"

)

INSIGHTFACE=(
    "https://huggingface.co/ezioruan/inswapper_128.onnx/resolve/main/inswapper_128.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/1k3d68.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/2d106det.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/det_10g.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/genderage.onnx"
    "https://huggingface.co/public-data/insightface/resolve/main/models/buffalo_l/w600k_r50.onnx"
)

INSIGHTFACE2=(
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/1k3d68.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/2d106det.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/genderage.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/glintr100.onnx"
    "https://huggingface.co/MonsterMMORPG/tools/resolve/main/scrfd_10g_bnkps.onnx"
)

UNET_MODELS=(
    # "https://huggingface.co/SG161222/Verus_Vision_1.0b/resolve/main/VerusVision_1.0b_Transformer_fp16.safetensors"
    "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/flux1-schnell.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/flux1-dev.safetensors"
)

LORA_MODELS=(
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sd15_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid-plusv2_sdxl_lora.safetensors"
    # "https://huggingface.co/h94/IP-Adapter-FaceID/resolve/main/ip-adapter-faceid_sdxl_lora.safetensors"
    "https://huggingface.co/XLabs-AI/flux-RealismLora/resolve/main/lora.safetensors"
)

VAE_MODELS=(
    # "https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
    # "https://huggingface.co/SG161222/Verus_Vision_1.0b/resolve/main/ae.safetensors"
    "https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors"
    # "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/ae.safetensors"
)


UPSCALE_MODELS=(
    # "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    # "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    # "https://huggingface.co/datasets/Kizi-Art/Upscale/resolve/fa98e357882a23b8e7928957a39462fbfaee1af5/4x-UltraSharp.pth"
    # "https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
    "https://huggingface.co/gemasai/4x_NMKD-Superscale-SP_178000_G/resolve/main/4x_NMKD-Superscale-SP_178000_G.pth"
    "https://huggingface.co/airomix/models/resolve/959e06106e9a212f2137ac145e6a2d6919ac1d56/4x-NMKD-Superscale.pt"
)


PULID=(
    # "https://huggingface.co/guozinan/PuLID/resolve/main/pulid_flux_v0.9.0.safetensors"
)


FACESTORE_MODELS=(
    "https://huggingface.co/talhaty/GFPGANv1.4/resolve/main/GFPGANv1.4.pth"
    )

FACEDETECTION=(
    "https://huggingface.co/darkeril/collection/resolve/main/detection_Resnet50_Final.pth"
)

ULTRALYTICS=(
    "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
    "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

CONTROLNET_MODELS=(
    # "https://huggingface.co/lllyasviel/sd_control_collection/resolve/main/diffusers_xl_canny_mid.safetensors"
    # "https://huggingface.co/InstantX/FLUX.1-dev-Controlnet-Union/resolve/main/diffusion_pytorch_model.safetensors"
    # "https://huggingface.co/thibaud/controlnet-openpose-sdxl-1.0/resolve/main/OpenPoseXL2.safetensors"
    # "https://huggingface.co/jasperai/Flux.1-dev-Controlnet-Upscaler/resolve/main/diffusion_pytorch_model.safetensors"
    # "https://huggingface.co/lllyasviel/sd-controlnet-openpose/resolve/main/diffusion_pytorch_model.safetensors"
    # "https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth"
    # "https://huggingface.co/lllyasviel/sd-controlnet-openpose/resolve/main/diffusion_pytorch_model.safetensors"
)

CLIP=(
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors"
    "https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors"
    # "https://huggingface.co/QuanSun/EVA-CLIP/resolve/main/EVA02_CLIP_L_336_psz14_s6B.pt"
)

CLIP_VISION=(
    "https://huggingface.co/laion/CLIP-ViT-H-14-laion2B-s32B-b79K/resolve/main/model.safetensors"
)

ULTRALYTICS=(
  "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt"
  "https://huggingface.co/Bingsu/adetailer/resolve/main/hand_yolov8s.pt"
)

VITMATTE=(
"https://huggingface.co/hustvl/vitmatte-base-composition-1k/resolve/main/pytorch_model.bin"
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
        "${WORKSPACE}/storage/stable_diffusion/models/facestore_models" \
        "${FACESTORE_MODELS[@]}"
    provisioning_get_files \
        "${WORKSPACE}/storage/stable_diffusion/models/facedetection" \
        "${FACEDETECTION[@]}"
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
        "${WORKSPACE}/storage/stable_diffusion/models/ultralytics" \
        "${ULTRALYTICS[@]}"
    provisioning_get_files \
        "${WORKSPACE}/storage/stable_diffusion/models/vitmatte" \
        "${VITMATTE[@]}"
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


# Allow user to disable provisioning if they started with a script they didn't want
if [[ ! -f /.noprovisioning ]]; then
    provisioning_start
fi
