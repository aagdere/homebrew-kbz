cask "kbz" do
  version "0.1.3084"
  sha256 "069ce084b3865b731c1df8833eb3334202bd94a03e154f5c137d757e67475380"

  url "https://github.com/aagdere/kbz/releases/download/v0.1.3084/Kibitz-#{version}-arm64-mac.zip"
  name "Kibitz"
  desc "Run coding agents on your repositories from your Mac and iPhone"
  homepage "https://github.com/aagdere/kbz"

  # the app updates itself, from its server's update feed (#1590)
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Kibitz.app"

  uninstall quit: "dev.aris.kibitz"

  zap trash: [
    "~/Library/Application Support/Kibitz",
    "~/Library/Logs/Kibitz",
    "~/Library/Preferences/dev.aris.kibitz.plist",
    "~/Library/Saved Application State/dev.aris.kibitz.savedState",
  ]

  caveats <<~EOS
    Open Kibitz to set it up: it installs the Kibitz server on this Mac, or
    uses one that already runs here (brew install aagdere/kbz/kbz).
  EOS
end
