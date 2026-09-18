class Vidp < Formula
  desc "Minimal libmpv-based video player for macOS"
  homepage "https://github.com/mdopeace/vidp"
  url "https://github.com/mdopeace/vidp/archive/refs/tags/v0.12.2.tar.gz"
  sha256 "f1fd7650de57cfaa04594b5a0ff390f60dff129e532897c65fb032a156e26454"

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

      To install it in /Applications, open vidp and use Check for Updates.
    EOS
  end

  test do
    assert_predicate opt_libexec/"vidp.app/Contents/MacOS/vidp", :executable?
  end
end
