class GitStandup < Formula
  desc "Recall what you did on the last working day - or see what someone else did"
  homepage "https://github.com/hollanddd/git-standup-rs"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.1/git-standup-aarch64-apple-darwin.tar.gz"
      sha256 "d363991ff00f22b9b93b82b0a61211a94370d8b4a9a76cca8e621d3202f170fd"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.1/git-standup-x86_64-apple-darwin.tar.gz"
      sha256 "938744be8298b4f78851382b21cc8a0b173c78c11961aa66da81c3ea7f0aa885"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.1/git-standup-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7070ef9a4a224d9f01803367c27443abc87cc87f84551253ceb3e3239bf8d8fa"
    end
    on_intel do
      url "https://github.com/hollanddd/git-standup-rs/releases/download/v0.2.1/git-standup-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5dbffda30b12c11ca353efd7a83963937454a6f80c0c32c0a027519c7232219"
    end
  end

  def install
    bin.install "git-standup"
  end

  test do
    assert_match "git-standup", shell_output("#{bin}/git-standup --version")
  end
end
