# frozen_string_literal: true

cask "vidp" do
  version "0.14.0"
  sha256 "6a0693eb1b1d51903141d7f025f59f5d7285f986686de9d73c3e4c9555d47ee1"

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
