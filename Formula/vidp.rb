class Vidp < Formula
  desc "Minimal libmpv-based video player for macOS"
  homepage "https://github.com/mdopeace/vidp"
  url "https://github.com/mdopeace/vidp/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "2dfd5db1a5761df8e84c143593c57e62098c67890397022acd53bcdc8557b391"

  depends_on :macos
  depends_on "mpv"
  depends_on :xcode

  def install
    ENV["MPV_PREFIX"] = formula_opt_prefix("mpv").to_s
    system "bash", "scripts/build.sh"
    libexec.install "vidp.app"
    (libexec/"install-app.sh").write <<~SH
      #!/bin/bash
      set -u

      source_app="${1}"
      destination="/Applications/vidp.app"
      backup="/Applications/.vidp.app.previous"

      if [[ -e "${destination}" ]]
      then
        bundle_id=$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "${destination}/Contents/Info.plist" 2>/dev/null || true)
        if [[ "${bundle_id}" != "com.vidp.vidp" ]]
        then
          echo "Warning: skipped /Applications/vidp.app because it belongs to another application." >&2
          exit 0
        fi
      fi

      rm -rf "${backup}"
      if [[ -e "${destination}" ]]
      then
        mv "${destination}" "${backup}" ||
          {
            echo "Warning: could not update /Applications/vidp.app." >&2
            exit 0
          }
      fi

      if ! ditto "${source_app}" "${destination}"
      then
        rm -rf "${destination}"
        if [[ -e "${backup}" ]]
        then
          mv "${backup}" "${destination}"
        fi
        echo "Warning: could not copy vidp.app to /Applications." >&2
        exit 0
      fi

      rm -rf "${backup}"
      echo "Installed vidp.app in /Applications"
    SH
    chmod 0755, libexec/"install-app.sh"
  end

  post_install_steps do
    run "install-app.sh",
      args:           ["{{libexec}}/vidp.app"],
      base:           :libexec,
      writable_paths: ["/Applications"]
  end

  def caveats
    <<~EOS
      vidp.app was built and installed to:
        #{opt_libexec}/vidp.app

      To launch it:
        open "#{opt_libexec}/vidp.app"

      It is also copied automatically to /Applications after install or upgrade.
      If /Applications is not writable, launch the bundle above or copy it manually.
    EOS
  end

  test do
    assert_predicate opt_libexec/"vidp.app/Contents/MacOS/vidp", :executable?
  end
end
