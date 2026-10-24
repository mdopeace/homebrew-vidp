# frozen_string_literal: true

cask "vidp" do
  version "0.15.0"
  sha256 "c0a41ee589958a6883250fa00fd79760936db5863bc1cca63296412d027f57dd"

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
