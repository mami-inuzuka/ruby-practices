# frozen_string_literal: true

require 'minitest/autorun'
require './lib/short_format'

class ShortFormatTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def test_run_ls_width_123
    expected = <<~TEXT.chomp
      Gemfile                 Rakefile                bin                     lib                     public
      Gemfile.lock            app                     config                  log                     test
      Procfile                app.json                config.ru               package.json            vendor
      README.md               babel.config.js         db                      postcss.config.js       yarn.lock
    TEXT
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 123).list
  end

  def test_run_ls_width_106
    expected = <<~TEXT.chomp
      Gemfile                 app                     config.ru               postcss.config.js
      Gemfile.lock            app.json                db                      public
      Procfile                babel.config.js         lib                     test
      README.md               bin                     log                     vendor
      Rakefile                config                  package.json            yarn.lock
    TEXT
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 106).list
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
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 72).list
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
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 37).list
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
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 1).list
  end

  def test_run_ls_reverse
    expected = <<~TEXT.chomp
      yarn.lock               postcss.config.js       db                      babel.config.js         README.md
      vendor                  package.json            config.ru               app.json                Procfile
      test                    log                     config                  app                     Gemfile.lock
      public                  lib                     bin                     Rakefile                Gemfile
    TEXT
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 123, reverse: true).list
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
    assert_equal expected, LS::ShortFormat.new(pathname: TARGET_PATHNAME, width: 123, dot_match: true).list
  end

end
