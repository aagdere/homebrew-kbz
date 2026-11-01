cask "kbz" do
  version "0.1.2846"
  sha256 "be29cbcbf850c28bbaf77d9c7157662930df611ce7edafb2d8e9cd3d9eaf7aca"

  url "https://github.com/aagdere/kbz/releases/download/v0.1.2846/Kibitz-#{version}-arm64-mac.zip"
  name "Kibitz"
  desc "Run coding agents on your repositories from your Mac and iPhone"
  homepage "https://github.com/aagdere/kbz"

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
