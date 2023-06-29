#!/bin/bash


CACHE_FOLDER=/tmp/.cache/i3lock/img/
# Create the cache folder if it does not exist
if ! [ -e $CACHE_FOLDER ]; then
    mkdir -p $CACHE_FOLDER
fi

BKG_IMG="${HOME}/bg.png"
MD5_BKG_IMG=$(md5sum $BKG_IMG | cut -c 1-10)
MD5_SCREEN_CONFIG=$(xrandr | md5sum - | cut -c 1-32) # Hash of xrandr output
OUTPUT_IMG="$CACHE_FOLDER""$MD5_SCREEN_CONFIG"."$MD5_BKG_IMG".png # Path of final image
OUTPUT_IMG_WIDTH=0 # Decide size to cover all screens
OUTPUT_IMG_HEIGHT=0 # Decide size to cover all screens
PARAMS="-colorspace sRGB" # ensure that images are created in sRGB colorspace, to avoid greyscale output

LOCK_CMD="i3lock -i $OUTPUT_IMG"
# LOCK_CMD="xdg-open $OUTPUT_IMG" # For testing

DISPLAY_RE="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)" # Regex to find display dimensions

echo "Checking for ${OUTPUT_IMG}"

if [ -e $OUTPUT_IMG ]
then
    echo "${OUTPUT_IMG} already exists, locking..."
    # Lock screen since image already exists
    $LOCK_CMD
    exit 0
fi

echo "${OUTPUT_IMG} not found. Generating..."

while read LINE; do
  if [[ $LINE =~ $DISPLAY_RE ]]; then
    #Extract information and append some parameters to the ones that will be given to ImageMagick:
    SCREEN_WIDTH=${BASH_REMATCH[1]}
    SCREEN_HEIGHT=${BASH_REMATCH[2]}
    SCREEN_X=${BASH_REMATCH[3]}
    SCREEN_Y=${BASH_REMATCH[4]}
    CACHE_IMG="$CACHE_FOLDER""$SCREEN_WIDTH"x"$SCREEN_HEIGHT"."$MD5_BKG_IMG".png

    echo "Checking ${CACHE_IMG}"

    if ! [ -e $CACHE_IMG ]; then
      echo "${CACHE_IMG} does not exist, generating..."
      # Create image for that screensize
      eval convert '$BKG_IMG' '-resize' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}^' '-gravity' 'Center' '-crop' '${SCREEN_WIDTH}X${SCREEN_HEIGHT}+0+0' '+repage' '$CACHE_IMG'
    fi

    # Decide size of output image
    if (( $OUTPUT_IMG_WIDTH < $SCREEN_WIDTH+$SCREEN_X )); then OUTPUT_IMG_WIDTH=$(($SCREEN_WIDTH+$SCREEN_X)); fi;
    if (( $OUTPUT_IMG_HEIGHT < $SCREEN_HEIGHT+$SCREEN_Y )); then OUTPUT_IMG_HEIGHT=$(( $SCREEN_HEIGHT+$SCREEN_Y )); fi;

    PARAMS="$PARAMS -type TrueColor $CACHE_IMG -geometry +$SCREEN_X+$SCREEN_Y -composite "
  fi
done <<< "`xrandr`"

#Execute ImageMagick:
eval convert -size ${OUTPUT_IMG_WIDTH}x${OUTPUT_IMG_HEIGHT} 'xc:black' $OUTPUT_IMG
eval convert $OUTPUT_IMG $PARAMS $OUTPUT_IMG

echo "Convert finished, locking..."

$LOCK_CMD

exit 0
