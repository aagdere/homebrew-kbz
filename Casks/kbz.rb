cask "kbz" do
  version "0.1.4823"
  sha256 "58622af76a8c51c0b313b2ea6397ad568403bd2fde2c8272fbc3f7bf03047411"

  url "https://github.com/aagdere/kbz/releases/download/v0.1.4823/Kibitz-#{version}-arm64-mac.zip"
  name "Kibitz"
  desc "Run coding agents on your repositories from your Mac and iPhone"
  homepage "https://github.com/aagdere/kbz"

  # the app updates itself, from its server's update feed (#1590)
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Kibitz.app"

  # #2560: the same set kbz uninstall removes (docs/uninstall.md)
  uninstall quit:      "dev.aris.kibitz",
            launchctl: [
              "app.kibitz.server",
              "app.kibitz.server.logrotate",
              "dev.aris.kibitz.server",
              "dev.aris.kibitz.server.logrotate",
            ],
            delete:    [
              "~/Library/Application Support/kibitz-desktop/server",
              "~/Library/Application Support/Kibitz/server",
              "~/.glm-console/helpers",
              "~/Library/Application Support/kibitz-desktop/Kibitz Browser.app",
              "~/Library/Application Support/Kibitz/Kibitz Browser.app",
              "~/Library/Application Support/kibitz-desktop/Kibitz Browser.version",
              "~/Library/Application Support/Kibitz/Kibitz Browser.version",
            ]

  zap launchctl: [
        "app.kibitz.server",
        "app.kibitz.server.logrotate",
        "dev.aris.kibitz.server",
        "dev.aris.kibitz.server.logrotate",
      ],
      script:    { executable: "/bin/sh", args: ["-c", "/usr/bin/security delete-generic-password -s 'kibitz-desktop Safe Storage' >/dev/null 2>&1; /usr/bin/security delete-generic-password -s 'Kibitz Safe Storage' >/dev/null 2>&1; true"], must_succeed: false },
      trash:     [
        "~/Library/Logs/kibitz-desktop",
        "~/Library/Logs/Kibitz",
        "~/Library/Caches/dev.aris.kibitz",
        "~/Library/Caches/dev.aris.kibitz.ShipIt",
        "~/Library/Caches/kibitz-desktop",
        "~/Library/Caches/Kibitz",
        "~/Library/Caches/kibitz-input",
        "~/Library/HTTPStorages/dev.aris.kibitz",
        "~/Library/Saved Application State/dev.aris.kibitz.savedState",
        "~/Library/Preferences/dev.aris.kibitz.plist",
        "~/Library/Preferences/com.kibitz.connector-browser.plist",
        "~/Library/Application Support/kibitz-desktop",
        "~/Library/Application Support/Kibitz",
        "~/Library/Application Support/glm-console-desktop",
        "~/.glm-console",
      ]

  caveats <<~EOS
    Open Kibitz to set it up: it installs the Kibitz server on this Mac, or
    uses one that already runs here (brew install aagdere/kbz/kbz).
  EOS
end
