class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/u/releases/download/v1.1.0/u-mac-v1.1.0.tar.gz"
  sha256 "6183578cdfcfb1a751c05a903302e127352d1553948f3be0a5c58d5bcf64d773"
  version "1.1.0"
  license "MIT"

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
