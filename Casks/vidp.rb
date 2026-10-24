# frozen_string_literal: true

cask "vidp" do
  version "0.16.1"
  sha256 "d0ffd8a3340dd1a5fa19043b9e8d18afeedffad531fa61f23c8997eb5b3d4b25"

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
