rbear: command line automation for `bundle exec rspec` with the Appraisal gem

# Basic Use

```bash
rbear v0.1.0
---------------------
A shell automation script for running 'bundle exec rspec' with appraisals
 
Basic use:
 
  rbear [[option] | [appraisal name]] [spec file(s)]
 
Command line options:
 
  -a  --all        # run rspec, plus all of the appraisals
  -h  --help       # this help screen
  -v  --version    # show the current rbear version
 
Examples:
 
  1. run rspec on a file with all appraisals:
 
     rbear spec/foo/bar_spec.rb
 
  2. run rspec on a file with an appraisal named 'rails-next':
 
     rbear rails-next spec/foo/bar_spec.rb
 
  3. run rspec on a file without any appraisals, and then with all appraisals:
 
     rbear --all spec/foo/bar_spec.rb
```

## LICENSE

MIT License
