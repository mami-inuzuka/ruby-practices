# frozen_string_literal: true

require 'minitest/autorun'
require './lib/ls_command'
require 'pathname'

class LsCommandTest < Minitest::Test
  TARGET_PATHNAME = Pathname('test/fixtures/sample-app')

  def test_run_ls_width_123
    expected = <<~TEXT.chomp
      Gemfile                 Rakefile                bin                     lib                     public
      Gemfile.lock            app                     config                  log                     test
      Procfile                app.json                config.ru               package.json            vendor
      README.md               babel.config.js         db                      postcss.config.js       yarn.lock
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 123).run_ls
  end

  def test_run_ls_width_106
    expected = <<~TEXT.chomp
      Gemfile                 app                     config.ru               postcss.config.js
      Gemfile.lock            app.json                db                      public
      Procfile                babel.config.js         lib                     test
      README.md               bin                     log                     vendor
      Rakefile                config                  package.json            yarn.lock
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 106).run_ls
  end

  def test_run_ls_width_72
    expected = <<~TEXT.chomp
      Gemfile                 babel.config.js         package.json
      Gemfile.lock            bin                     postcss.config.js
      Procfile                config                  public
      README.md               config.ru               test
      Rakefile                db                      vendor
      app                     lib                     yarn.lock
      app.json                log
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 72).run_ls
  end

  def test_run_ls_width_37
    expected = <<~TEXT.chomp
      Gemfile
      Gemfile.lock
      Procfile
      README.md
      Rakefile
      app
      app.json
      babel.config.js
      bin
      config
      config.ru
      db
      lib
      log
      package.json
      postcss.config.js
      public
      test
      vendor
      yarn.lock
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 37).run_ls
  end

  def test_run_ls_width_1
    expected = <<~TEXT.chomp
      Gemfile
      Gemfile.lock
      Procfile
      README.md
      Rakefile
      app
      app.json
      babel.config.js
      bin
      config
      config.ru
      db
      lib
      log
      package.json
      postcss.config.js
      public
      test
      vendor
      yarn.lock
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 1).run_ls
  end

  def test_run_ls_long_format
    # Output example
    # total 816
    # -rw-rw-r--  1 mami-inuzuka  staff    2049 10  8 14:52 Gemfile
    # -rw-rw-r--  1 mami-inuzuka  staff   13714 10  8 14:52 Gemfile.lock
    # -rw-rw-r--  1 mami-inuzuka  staff     111 10  8 14:52 Procfile
    # -rw-rw-r--  1 mami-inuzuka  staff    2201 10  8 14:52 README.md
    # -rwxr-xr-x  1 mami-inuzuka  staff     300 10  8 14:52 Rakefile
    # drwxrwxr-x 12 mami-inuzuka  staff     384 10  8 14:52 app
    # -rw-rw-r--  1 mami-inuzuka  staff     559 10  8 14:52 app.json
    # -rw-rw-r--  1 mami-inuzuka  staff    1722 10  8 14:52 babel.config.js
    # drwxrwxr-x 14 mami-inuzuka  staff     448 10  8 14:52 bin
    # drwxrwxr-x 19 mami-inuzuka  staff     608 10  8 14:52 config
    # -rw-rw-r--  1 mami-inuzuka  staff     160 10  8 14:52 config.ru
    # drwxrwxr-x  8 mami-inuzuka  staff     256 10  8 14:52 db
    # drwxrwxr-x  6 mami-inuzuka  staff     192 10  8 14:52 lib
    # drwxrwxr-x  3 mami-inuzuka  staff      96 10  8 14:52 log
    # -rw-rw-r--  1 mami-inuzuka  staff    1651 10  8 14:52 package.json
    # -rw-rw-r--  1 mami-inuzuka  staff     224 10  8 14:52 postcss.config.js
    # drwxrwxr-x 25 mami-inuzuka  staff     800 10  8 14:52 public
    # drwxrwxr-x 13 mami-inuzuka  staff     416 10  8 14:52 test
    # drwxrwxr-x  4 mami-inuzuka  staff     128 10  8 14:52 vendor
    # -rw-rw-r--  1 mami-inuzuka  staff  364177 10  8 14:52 yarn.lock
    expected = `ls -l #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, long_format: true)
  end

  def test_run_ls_reverse
    expected = <<~TEXT.chomp
      yarn.lock               postcss.config.js       db                      babel.config.js         README.md
      vendor                  package.json            config.ru               app.json                Procfile
      test                    log                     config                  app                     Gemfile.lock
      public                  lib                     bin                     Rakefile                Gemfile
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 123, reverse: true)
  end

  def test_run_ls_dot_match
    expected = <<~TEXT.chomp
      .                       .node-version           README.md               config                  postcss.config.js
      ..                      .rubocop.yml            Rakefile                config.ru               public
      .browserslistrc         .ruby-version           app                     db                      test
      .eslintrc               Gemfile                 app.json                lib                     vendor
      .github                 Gemfile.lock            babel.config.js         log                     yarn.lock
      .gitignore              Procfile                bin                     package.json
    TEXT
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, width: 123, dot_match: true)
  end

  def test_run_ls_all_options
    expected = `ls -lar #{TARGET_PATHNAME}`.chomp
    assert_equal expected, LS::Ls.new(TARGET_PATHNAME, long_format: true, reverse: true, dot_match: true)
  end
end
