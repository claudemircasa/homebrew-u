class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/homebrew-u/releases/download/v1.2.0/u-mac-v1.2.0.tar.gz"
  sha256 "051263712d04c4ffc97233f03f40dbfe7b6d68fc9852e779bbfc552c43038a0f"
  version "1.2.0"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
