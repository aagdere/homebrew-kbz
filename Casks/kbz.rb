cask "kbz" do
  version "0.1.4321"
  sha256 "02ecd77ecaae7837132c84e63b7b8d2f5b34d421b6161b74266bfb8f1e5b933b"

  url "https://github.com/aagdere/kbz/releases/download/v0.1.4321/Kibitz-#{version}-arm64-mac.zip"
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
