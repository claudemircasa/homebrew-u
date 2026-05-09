class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/homebrew-u/releases/download/v1.2.1/u-mac-v1.2.1.tar.gz"
  sha256 "78c3e0fe033ef5354d4d5c86fa4ed8d08e3ff03b631abc59648b674dc1c5d7e9"
  version "1.2.1"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
