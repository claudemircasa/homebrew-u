class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/homebrew-u/releases/download/v1.2.2/u-mac-v1.2.2.tar.gz"
  sha256 "e7d0042b07ff3c28ae6b4594180b432deebe38bc6edd12355729709ba7fe8d58"
  version "1.2.2"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
