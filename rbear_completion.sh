#/bin/zsh

function __rbear_get_appraisal_names {
  # list all the gemfiles and 
  # reduce the full file path to just the file name without the extension
  local appraisal_file_list=$(find ./gemfiles -type f -name "*.gemfile" -print0 | xargs -0 -I % basename % .gemfile)
  appraisal_file_list="${appraisal_file_list//_/-}"

  # take the search word provided and replace all - with _
  # local appraisal_file_search="${COMP_WORDS[1]//[-]/_}"

  # run the list completion
  COMPREPLY+=($(compgen -W "$appraisal_file_list" "$COMP_WORDS[1]"))
}

  # local appraisal_list=$(cat Appraisals | grep appraise)
  # if [[ $appraisal_list =~ "appraise\([\'\"](.+)[\'\"]" ]]; then
  #   echo -------------
  #   echo $match[1]
  #   echo -------------
  # else
  #   echo fail
  # fi

complete -F __rbear_get_appraisal_names rbear
