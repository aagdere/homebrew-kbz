class Kbz < Formula
  desc "Run coding agents on your repositories, from your Mac, iPhone and devices"
  homepage "https://github.com/aagdere/kbz"
  version "0.1.3719"
  license :cannot_represent

  depends_on :macos

  on_macos do
    on_arm do
      url "https://github.com/aagdere/kbz/releases/download/v0.1.3719/kbz-0.1.3719-darwin-arm64.tar.gz"
      sha256 "54c601507dc8a7a4096d0339a0a781f99e873d29fa80549303e32be14c15dbc1"
    end
    on_intel do
      url "https://github.com/aagdere/kbz/releases/download/v0.1.3719/kbz-0.1.3719-darwin-x64.tar.gz"
      sha256 "24b66b244424caff5cd0fe75d3250efa5a78dfbbad7a6ff1765ee02124516d58"
    end
  end

  def install
    libexec.install Dir["*"], Dir[".[!.]*"]
    (bin/"kbz").write <<~SH
      #!/bin/bash
      export KIBITZ_COMMAND=kbz KIBITZ_SERVICE=kbz KIBITZ_SERVICE_MANAGER=brew
      exec "#{opt_libexec}/node/bin/node" "#{opt_libexec}/kibitz/cli.mjs" "$@"
    SH
  end

  def caveats
    <<~EOS
      Choose what this Mac does, then start it:
        kbz setup
        brew services start kbz
      For the desktop app: brew install --cask aagdere/kbz/kbz
    EOS
  end

  service do
    run [opt_bin/"kbz", "run"]
    keep_alive successful_exit: false
    working_dir opt_libexec/"server"
    log_path var/"log/kbz.log"
    error_log_path var/"log/kbz.log"
    environment_variables PATH: std_service_path_env
  end

  test do
    assert_match "Kibitz #{version}", shell_output("#{bin}/kbz version")
  end
end
