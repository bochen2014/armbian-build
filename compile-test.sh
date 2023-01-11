SRC="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

echo './compile.sh docker BUILD_ONLY=u-boot,kernel BOARD=aml-s9xx-box BRANCH=current KERNEL_CONFIGURE=yes'
echo $SRC