class StringIO
  def wait_readable(*)
    true
  end

  def ioctl(*)
    80
  end
end

module SpecMixin
  def reset_config
    Config.path = 'tmp/config.yml'
    Config.email = 'eli@marko.com'
    Config.premium = true
    Config.session_key = 'dummy-session'
    Config.listen_key = 'dummy-listen'
    Config.network = 'di'
    Config.channel = 'trance'
    Config.cache_dir = 'cache'
    Config.cache_life = '10s'
    Config.like_log = 'tmp/like.log'
  end

  def reset_tmp_dir
    if Dir.exist? tmp_dir
      Dir["#{tmp_dir}/**/*"].each { |file| File.delete file if File.file? file }
    else
      # :nocov:
      Dir.mkdir tmp_dir
      # :nocov:
    end
  end

  def reset_like_log
    log_fixture = File.expand_path 'fixtures/like.log', __dir__
    system %[cp "#{log_fixture}" 'tmp/like.log']
  end

  def tmp_dir
    File.expand_path 'tmp', __dir__
  end

  def require_mock_server!
    result = HTTParty.get('http://localhost:3000/')
    result = JSON.parse result.body
    raise 'Please start the mock server' unless result['mockserver'] == 'online'
  rescue Errno::ECONNREFUSED
    # :nocov:
    raise 'Please start the mock server'
    # :nocov:
  end

  def keyboard
    {
      enter: '',
      down:  "\e[B",
      up:    "\e[A",
    }
  end

  def stdin_send(*args)
    $stdin = StringIO.new
    until args.empty?
      arg = args.shift % keyboard
      $stdin.puts arg
    end
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end

  def capture_output
    original_stdout = $stdout
    $stdout = StringIO.new
    begin
      yield
      $stdout.string
    ensure
      $stdout = original_stdout
    end
  end

  def interactive(...)
    if ENV['DEBUG'] == '2'
      # :nocov:
      interactive!(...)
      # :nocov:
    else
      capture_output { interactive!(...) }
    end
  end

  def interactive!(*args, &block)
    if args.any?
      stdin_send(*args, &block)
    else
      yield
    end
  end
end
