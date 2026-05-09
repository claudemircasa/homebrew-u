class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/homebrew-u/releases/download/v1.2.3/u-mac-v1.2.3.tar.gz"
  sha256 "fd9d14449f5570a8d65361dd676d79ab8d4eb4bfea2ca5d68fee2c753dbd3436"
  version "1.2.3"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
