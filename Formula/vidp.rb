class Vidp < Formula
  desc "Minimal libmpv-based video player for macOS"
  homepage "https://github.com/mdopeace/vidp"
  url "https://github.com/mdopeace/vidp/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "2a1982c3a2e431fa390fbee13820361c5597248df211210dda2f000dee0a137b"

  depends_on :macos
  depends_on "mpv"
  depends_on :xcode

  def install
    ENV["MPV_PREFIX"] = formula_opt_prefix("mpv").to_s
    system "bash", "build.sh"
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
