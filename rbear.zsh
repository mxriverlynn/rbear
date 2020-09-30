# load shell completion
source "$(dirname $0)/rbear_completion.sh"

RBEAR_VERSION="0.1.0"

function rbear {
  __rbear_version

  while [ "$1" != "" ]; do
    case $1 in
      -a | --all )
        __rbear_run_all ${@:2}
        return $?
        ;;
      -h | --help )
        __rbear_help
        return 0
        ;;
      -v | --version )
        __rbear_version
        return 0
        ;;
      * )
        __rbear_run $@
        return $?
        ;;
    esac
  done
}

function __rbear_version {
  echo " "
  echo "rbear v$RBEAR_VERSION"
  echo "------------"
}

function __rbear_help {
  __rbear_version
  echo "A shell automation script for running 'bundle exec rspec' with appraisals"
  echo " "
  echo "Basic use"
  echo "---------"
  echo " "
  echo "run rbear with a command line option"
  echo "  rbear [option]"
  echo " "
  echo "run 'bundle exec appraisal <appraisal name>' with spec files if provided"
  echo "  rbear <appraisal name> [spec file(s)]"
  echo " "
  echo "run 'bundle exec <command>' with any abitrary command and options"
  echo "  rbear <command> [option(s)]"
  echo " "
  echo "Command line options:"
  echo " "
  echo "  -a  --all     [spec file(s)] # run rspec, plus all named appraisals"
  echo "  -h  --help                   # this help screen"
  echo "  -v  --version                # show the current rbear version"
  echo " "
  echo "Examples:"
  echo " "
  echo "  1. run rspec on a file with no appraisals:"
  echo " "
  echo "     rbear spec/foo/bar_spec.rb"
  echo " "
  echo "  2. run rspec on a file with an appraisal named 'rails-next':"
  echo " "
  echo "     rbear rails-next spec/foo/bar_spec.rb"
  echo " "
  echo "  3. run rspec on a file without any appraisals, and then with all appraisals:"
  echo " "
  echo "     rbear --all spec/foo/bar_spec.rb"
  echo " "
  echo "  4. run a command such as sorbet's srb with options"
  echo " "
  echo "     rbear srb -tc"
}

function __rbear_run_all {
  echo "Running rspec and all appraisals"
  echo " "
  __rbear_run_rspec_without_appraisal $@
  __rbear_run_rspec_with_appraisal $@
}

function __rbear_run_rspec_with_appraisal {
  local appraisal_name=$1
  local appraisal_file=${appraisal_name//[-]/_}
  local opts=()

  echo "Running rspec with named appraisal: $appraisal_name"
  echo " "

  opts=( $appraisal_name rspec ${@:2} )
  bundle exec appraisal $opts
}

function __rbear_run_rspec_without_appraisal {
  echo "Running rspec without appraisals"
  echo " "

  bundle exec rspec $@
}

function __rbear_run_exec {
  echo "Running $1"
  echo " "

  bundle exec $@
}

function __rbear_run {
  local first_option=$1
  local appraisal_file=${1//[-]/_}

  if [ -f "gemfiles/$appraisal_file.gemfile" ]; then
    __rbear_run_rspec_with_appraisal $@
  elif $(which $first_option); then
    __rbear_run_exec $@
  else 
    __rbear_run_rspec_without_appraisal $@
  fi
}

alias rbe="bundle exec"
alias rbea="rbe appraisal"
alias rber="rbe rspec"
alias acab="rbe rubocop"
