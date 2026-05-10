class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/homebrew-u/releases/download/v1.3.0/u-mac-v1.3.0.tar.gz"
  sha256 "57b3ab7380579c45270f2527442f0f73c79d278144bad5f7d9e62028201cde77"
  version "1.3.0"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
