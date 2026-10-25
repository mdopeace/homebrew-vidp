# frozen_string_literal: true

cask "vidp" do
  version "0.17.0"
  sha256 "39b902176bedb4c2c88119a2438ef59a5432bc89c87e14b302ca7c6e233ac120"

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
