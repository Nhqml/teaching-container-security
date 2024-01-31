_RED='\033[0;31m'
_BOLD_RED='\033[1;31m'
_GREEN='\033[0;32m'
_BOLD_GREEN='\033[1;32m'
_YELLOW='\033[0;33m'
_BOLD_YELLOW='\033[1;33m'
_BLUE='\033[0;34m'
_BOLD_BLUE='\033[1;34m'
_PURPLE='\033[0;35m'
_BOLD_PURPLE='\033[1;35m'
_CYAN='\033[0;36m'
_BOLD_CYAN='\033[1;36m'
_WHITE='\033[0;37m'
_BOLD_WHITE='\033[1;37m'

_GRAY='\033[0;90m'
_BOLD_GRAY='\033[1;90m'

_RESET='\033[0m'

info () {
    printf "${_CYAN}[i] $1${_RESET}\n"
}

task () {
    printf "${_GREEN}[>] $1${_RESET}\n"
}

question () {
    printf "${_PURPLE}[?] $1${_RESET}\n"
}

attention () {
    printf "${_BOLD_RED}[!] $1${_RESET}\n"
}

command () {
    printf "   $ ${_YELLOW}$1${_RESET}\n"
}

notice () {
    printf "${_GRAY}$1${_RESET}\n"
}

start_demo () {
    split=false
    args=()

    while [[ $# -gt 0 ]]; do
        case $1 in
        --split)
            split=true
            ;;
        -*)
            echo "Error: Unknown option '$1' for start_demo function."
            exit 1
            ;;
        *)
            args+=("$1")
            ;;
        esac
        shift
    done

    zellij action clear
    if [ "$split" = true ]; then
        zellij action new-pane -d right
    else
        zellij action new-tab -n "${TAB_NAME}" -l "${DEMO_DIR}/zellij.kdl"
        zellij action go-to-tab 0
    fi

    info "Demo is ready"
    for arg in "${args[@]}"; do
        info "$arg"
    done
    printf "\n"
}

stop_demo () {
    split=false
    args=()

    while [[ $# -gt 0 ]]; do
        case $1 in
        --split)
            split=true
            ;;
        -*)
            echo "Error: Unknown option '$1' for start_demo function."
            exit 1
            ;;
        *)
            args+=("$1")
            ;;
        esac
        shift
    done

    echo ""
    notice "Press [RETURN] to exit demo... "
    read

    if [ "$split" = true ]; then
        zellij action move-focus right && zellij action close-pane
    else
        zellij action go-to-tab-name "${TAB_NAME}" && zellij action close-tab
    fi
    zellij action clear
}
