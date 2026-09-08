class Vidp < Formula
  desc "Minimal libmpv-based video player for macOS"
  homepage "https://github.com/mdopeace/vidp"
  url "https://github.com/mdopeace/vidp/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "80c43fed6026b028cd26186f416239b2a6772253c9cc1b3453d7ff17bb211f38"

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

      Or copy it to /Applications to use like any other app:
        cp -R "#{opt_libexec}/vidp.app" /Applications/
    EOS
  end

  test do
    assert_predicate opt_libexec/"vidp.app/Contents/MacOS/vidp", :executable?
  end
end
