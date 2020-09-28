if [[ ! -o interactive ]]; then
    return
fi

compctl -K _rbear rbear

function _rbear() {
  local words completions file_and_folder_list appraisal_file_list

  read -cA words
  if [ "${#words}" -eq 2 ]; then
    # Appraisal List
    appraisal_file_list=$(find ./gemfiles -type f -name "*.gemfile" -print0 | xargs -0 -I % basename % .gemfile)
    completions="${appraisal_file_list//_/-}"
  fi

  # Folder and File Names
  #file_and_folder_list=$(find $words[-1] -maxdepth 1 ! -path . | cut -c3- | xargs echo)
  #completions+=($file_and_folder_list)

  # Generate Completion List
  # ------------------------
  # COMPREPLY=($(compgen -W "$appraisal_file_list $file_and_folder_list" "$COMP_WORDS[1]"))
  reply=($completions)
  reply=(foo bar baz)
}
