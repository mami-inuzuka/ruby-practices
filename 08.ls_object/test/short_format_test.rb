# frozen_string_literal: true

require 'minitest/autorun'
require './lib/ls_command'
require './lib/short_format'
require 'pathname'

class ShortFormatTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def test_run_ls_width_123
    expected = <<~TEXT.chomp
      Gemfile                 Rakefile                bin                     lib                     public
      Gemfile.lock            app                     config                  log                     test
      Procfile                app.json                config.ru               package.json            vendor
      README.md               babel.config.js         db                      postcss.config.js       yarn.lock
    TEXT
    assert_equal expected, LS::ShortFormat.new(TARGET_PATHNAME, 123).list
  end

  def test_run_ls_width_106
    expected = <<~TEXT.chomp
      Gemfile                 app                     config.ru               postcss.config.js
      Gemfile.lock            app.json                db                      public
      Procfile                babel.config.js         lib                     test
      README.md               bin                     log                     vendor
      Rakefile                config                  package.json            yarn.lock
    TEXT
    assert_equal expected, LS::ShortFormat.new(TARGET_PATHNAME, 106).list
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
    assert_equal expected, LS::ShortFormat.new(TARGET_PATHNAME, 72).list
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
    assert_equal expected, LS::ShortFormat.new(TARGET_PATHNAME, 37).list
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
    assert_equal expected, LS::ShortFormat.new(TARGET_PATHNAME, 1).list
  end
end
