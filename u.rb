class U < Formula
  desc "Universal Abstract Language (U) Compiler & U-Shell"
  homepage "https://governor.ltd"
  url "https://github.com/claudemircasa/u/releases/download/v1.1.1/u-mac-v1.1.1.tar.gz"
  sha256 "c16038b692e8fbc59f58d8dae8dc025b0f93cea232ea77c2cd00decfb481175c"
  version "1.1.1"
  # Proprietary license: Governor Ltda.

  def install
    bin.install "u"
  end

  test do
    # Simply running the shell and exiting
    system "#{bin}/u", "--version"
  end
end
