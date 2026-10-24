# frozen_string_literal: true

cask "vidp" do
  version "0.16.0"
  sha256 "1edf004724270850653213b181a48720a10850fd87daf602b3ee6e3dc02e31c6"

  url "https://github.com/mdopeace/vidp/releases/download/v#{version}/vidp.app.zip"
  name "vidp"
  desc "Minimal keyboard-driven video player built on libmpv"
  homepage "https://github.com/mdopeace/vidp"

  depends_on macos: :ventura

  app "vidp.app"

  # Ad-hoc signed, not notarized, so Gatekeeper blocks the first launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/vidp.app"],
        must_succeed: false
  end
end
