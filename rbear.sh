# load bash-complete
source "$(dirname $0)/rbear_completion.sh"

RBEAR_VERSION="0.1.0"

function rbear {
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
        __rbear_run_rspec_with_appraisal $@
        return $?
        ;;
    esac
  done
}

function __rbear_version {
  echo "rbear v$RBEAR_VERSION"
}

function __rbear_help {
  __rbear_version
  echo "---------------------"
  echo "A shell automation script for running 'bundle exec rspec' with appraisals"
  echo " "
  echo "Basic use:"
  echo " "
  echo "  rbear [[option] | [appraisal name]] [spec file(s)]"
  echo " "
  echo "Command line options:"
  echo " "
  echo "  -a  --all        # run rspec, plus all of the appraisals"
  echo "  -h  --help       # this help screen"
  echo "  -v  --version    # show the current rbear version"
  echo " "
  echo "Examples:"
  echo " "
  echo "  1. run rspec on a file with all appraisals:"
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
}

function __rbear_run_all {
  echo "Running rspec and all appraisals"
  __rbear_run_rspec_without_appraisal $@
  __rbear_run_rspec_with_appraisal $@
}

function __rbear_run_rspec_without_appraisal {
  bundle exec rspec $@
}

function __rbear_run_rspec_with_appraisal {
  local appraisal_name=$1
  local appraisal_file=${1//[-]/_}
  local opts=()

  if [ -f "gemfiles/$appraisal_file.gemfile" ]; then
    echo "Running rspec with named appraisal: $appraisal_name"
    echo " "
    opts=( $appraisal_name rspec ${@:2} )
  else
    echo "Running rspec with all appraisals"
    echo " "
    opts=( rspec $@ )
  fi

  bundle exec appraisal $opts
}

alias rbe="bundle exec"
alias rbea="rbe appraisal"
alias rber="rbe rspec"
alias acab="rbe rubocop"
