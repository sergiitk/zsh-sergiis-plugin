#!/usr/bin/env zsh

change_mode() {
  local serial="${1:-s30592}"
  emulate -L zsh
  setopt extended_glob

  if [[ "${serial}" != s[[:digit:]]## ]]; then
    print -u2 -- "Wrong serial number format: ${serial}"
    return 1
  fi
  local normal_mode="1" alt_mode="9" set_mode="${2:-}"
  local display_info current_mode_str current_mode_int

  display_info="$(displayplacer list | sed -n "/${serial}/,/^$/p" | grep -v "color_depth:4" | head -n-1)"
  if [[ -z $display_info ]]; then
    print -u2 -- "Serial number not found: ${serial}"
    return 1
  fi
  if [[ $set_mode == "-l" ]]; then
    echo "${display_info}"
    return 1
  fi

  current_mode_str="$(echo "$display_info" | grep -oE 'mode [0-9]+: .*<-- current mode')"
  current_mode_int="$(echo "$current_mode_str" | grep -oP '(?<=mode )[0-9]+(?=:)')"
  if [[ -z "${current_mode_str}" || -z "${current_mode_int}" ]]; then
    print -u2 -- "Current mode not detected"
    return 1
  fi

  echo "${current_mode_str}"

  if [[ -z "${set_mode}" ]]; then
    if [[ "${current_mode_int}" == "${normal_mode}" ]]; then
      set_mode="${alt_mode}"
    else
      set_mode="${normal_mode}"
    fi
  elif [[ $set_mode != [[:digit:]]## ]]; then
    print -u2 -- "Wrong mode format: ${set_mode}"
    return 1
  fi

  local new_mode_str
  new_mode_str=$(echo "$display_info" | grep -oE "mode ${set_mode}: .*")
  if [[ -z $new_mode_str ]]; then
    print -u2 -- "Requested mode not found: ${set_mode}"
    return 1
  fi

  echo "${new_mode_str} <-- setting new mode"
  displayplacer "id:${serial} mode:${set_mode}"
}

change_mode "$@"
