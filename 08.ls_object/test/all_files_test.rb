# frozen_string_literal: true

require 'minitest/autorun'
require './lib/file_collector'

class LsFileTest < Minitest::Test
  TARGET_PATHNAME = 'test/fixtures/sample-app'

  def test_all_files
    expected = ["test/fixtures/sample-app/Gemfile", "test/fixtures/sample-app/Gemfile.lock", "test/fixtures/sample-app/Procfile", "test/fixtures/sample-app/README.md", "test/fixtures/sample-app/Rakefile", "test/fixtures/sample-app/app", "test/fixtures/sample-app/app.json", "test/fixtures/sample-app/babel.config.js", "test/fixtures/sample-app/bin", "test/fixtures/sample-app/config", "test/fixtures/sample-app/config.ru", "test/fixtures/sample-app/db", "test/fixtures/sample-app/lib", "test/fixtures/sample-app/log", "test/fixtures/sample-app/package.json", "test/fixtures/sample-app/postcss.config.js", "test/fixtures/sample-app/public", "test/fixtures/sample-app/test", "test/fixtures/sample-app/vendor", "test/fixtures/sample-app/yarn.lock"]
    assert_equal expected, LS::FileCollector.new(pathname: TARGET_PATHNAME).file_paths
  end
end
