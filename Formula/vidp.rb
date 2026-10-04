class Vidp < Formula
  desc "Minimal libmpv-based video player for macOS"
  homepage "https://github.com/mdopeace/vidp"
  url "https://github.com/mdopeace/vidp/archive/refs/tags/v0.12.3.tar.gz"
  sha256 "0e41a4fcec1449ad91977c4668a5a6ceb4a65a3c6fbe91d6bcfab6e481960cd9"

  depends_on :macos
  depends_on "mpv"
  depends_on :xcode

  def install
    ENV["MPV_PREFIX"] = formula_opt_prefix("mpv").to_s
    system "bash", "scripts/build.sh"
    libexec.install "vidp.app"
  end

  def caveats
    <<~EOS
      vidp.app was built and installed to:
        #{opt_libexec}/vidp.app

      To launch it:
        open "#{opt_libexec}/vidp.app"

      To install or update it in /Applications:
        cp -R "#{opt_libexec}/vidp.app" /Applications/

      This overwrites the files in an existing copy, but won't remove any a
      new version no longer ships. The app's Check for Updates command
      replaces the copy outright.
    EOS
  end

  test do
    assert_predicate opt_libexec/"vidp.app/Contents/MacOS/vidp", :executable?
  end
end
