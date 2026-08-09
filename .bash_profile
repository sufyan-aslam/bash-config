# ============================================
#  LIGHT SCHEME + EMOJI/UNICODE ICONS
# ============================================
CLEAR=$'\e[0m'

# ----- Backgrounds (24-bit True Color) -----
BG_USER=$'\e[48;2;249;171;0m'      # Orange
BG_PATH=$'\e[48;2;66;133;244m'     # Blue
BG_GIT_CLEAN=$'\e[48;2;52;168;83m' # Green
BG_GIT_DIRTY=$'\e[48;2;251;188;5m' # Yellow
BG_TIMER=$'\e[48;2;249;171;0m'     # Orange
BG_ERROR=$'\e[48;2;234;67;53m'     # Red

# ----- Foregrounds -----
FG_WHITE=$'\e[38;2;255;255;255m'
FG_BLACK=$'\e[38;2;0;0;0m'
FG_SEP=$'\e[38;2;154;160;166m'
FG_TIMESTAMP=$'\e[38;2;154;160;166m'
FG_WHITE_ARROW=$'\e[38;2;255;255;255m'

# ============================================
# PROMPT ENGINE
# ============================================
__set_prompt() {
    local exit_code=$?

    # ----- GIT STATUS (⎇ = branch symbol) -----
    local git_text=""
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        if [[ -n $branch ]]; then
            local status=$(git status --porcelain 2>/dev/null)
            local added=0 modified=0 deleted=0 renamed=0

            if [[ -n $status ]]; then
                while IFS= read -r line; do
                    case "${line:0:2}" in
                        "A "|"AM") ((added++)) ;;
                        " M"|"MM") ((modified++)) ;;
                        "D "|"DM") ((deleted++)) ;;
                        "R "|"RM") ((renamed++)) ;;
                    esac
                done <<< "$status"
            fi

            local changes=""
            [[ $added -gt 0 ]]    && changes+=" +$added"
            [[ $modified -gt 0 ]] && changes+=" ~$modified"
            [[ $deleted -gt 0 ]]  && changes+=" -$deleted"
            [[ $renamed -gt 0 ]]  && changes+=" >$renamed"

            if [[ -n $status ]]; then
                git_text="\[${BG_GIT_DIRTY}\]\[${FG_BLACK}\] ⎇ :${branch}:${changes} \[${CLEAR}\]"
            else
                git_text="\[${BG_GIT_CLEAN}\]\[${FG_BLACK}\] ⎇ :${branch}:${changes} \[${CLEAR}\]"
            fi
        fi
    fi

    # ----- TIMER (if command > 2s) -----
    local duration_text=""
    if [[ -n $_CMD_START ]]; then
        local elapsed=$(( $(date +%s) - _CMD_START ))
        if [[ $elapsed -ge 2 ]]; then
            duration_text="\[${BG_TIMER}\]\[${FG_WHITE}\] ${elapsed}s \[${CLEAR}\]"
        fi
    fi

    # ----- ERROR (if command failed) -----
    local error_text=""
    if [[ $exit_code -ne 0 ]]; then
        error_text="\[${BG_ERROR}\]\[${FG_WHITE}\] ✘ ${exit_code} \[${CLEAR}\]"
    fi

    # ----- TIMESTAMP (HH:MM:SS) -----
    local timestamp_text="\[${FG_TIMESTAMP}\]$(date +%H:%M:%S)\[${CLEAR}\]"

    # ----- BUILD PILLS (📁 = folder icon) -----
    local user_pill="\[${BG_USER}\]\[${FG_WHITE}\] \u \[${CLEAR}\]"
    local path_pill="\[${BG_PATH}\]\[${FG_WHITE}\] 📁 \w \[${CLEAR}\]"
    local sep="\[${FG_SEP}\]:\[${CLEAR}\]"

    # ----- ASSEMBLE -----
    PS1="\n${user_pill}${sep}${path_pill}${sep}${git_text}${duration_text}${error_text}"
    PS1+="\n${timestamp_text} \[${FG_WHITE_ARROW}\]➜ \[${CLEAR}\]"

    _CMD_START=$(date +%s)
}

PROMPT_COMMAND=__set_prompt
