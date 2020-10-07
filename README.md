**rbear**: A command line wrapper for ruby's `bundle exec`, w/ `appraisal` and `rspec`

# Basic Use

add `source path/to/rbear/rbear.sh` to your shell's .rc file

```bash
rbear v0.1.0
------------
A shell automation script for running 'bundle exec rspec' with appraisals
 
Basic use
---------
 
run rbear with a command line option
  rbear [option]
 
run 'bundle exec appraisal <appraisal name>' with spec files if provided
  rbear <appraisal name> [spec file(s)]
 
run 'bundle exec <command>' with any abitrary command and options
  rbear <command> [option(s)]
 
Command line options:
 
  -a  --all     [spec file(s)] # run rspec, plus all named appraisals
  -h  --help                   # this help screen
  -v  --version                # show the current rbear version
 
Examples:
 
  1. run rspec on a file with no appraisals:
 
     rbear spec/foo/bar_spec.rb
 
  2. run rspec on a file with an appraisal named 'rails-next':
 
     rbear rails-next spec/foo/bar_spec.rb
 
  3. run rspec on a file without any appraisals, and then with all appraisals:
 
     rbear --all spec/foo/bar_spec.rb
 
  4. run a command such as sorbet's srb with options
 
     rbear srb -tc
```

## LICENSE

MIT License
