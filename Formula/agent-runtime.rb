# Scratch copy of the formula in afrossard/homebrew-tap.
class AgentRuntime < Formula
  desc "Launcher and cleanup script for the agent runtime (afrossard/container-base)"
  homepage "https://github.com/afrossard/container-base"
  url "https://github.com/afrossard/container-base/releases/download/5.2.0/container-base-5.2.0.tar.gz"
  sha256 "9ab9392e9f404c098247af7927db304f3ca5db7aae7cddc53353f21bcc312ed4"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/afrossard/scratch"
    rebuild 1
    manifest_sha256 "bd6b7b799bf50f26f0692d97c7b3c4c5bc90d494436ad88d9d9478a3201e305e"
    sha256 cellar: :any_skip_relocation, all: "b31888ecd61e26d2e3d324fb1feff46342306da2a70da5b23a41e56fbbc3fd9f"
  end

  def install
    libexec.install "scripts/launch-agent-runtime"
    libexec.install "scripts/cleanup-agent-sessions"
    (libexec/"lib").install "scripts/lib/agent-runtime.sh"
    bin.write_exec_script libexec/"launch-agent-runtime"
    bin.write_exec_script libexec/"cleanup-agent-sessions"
  end

  test do
    system "#{bin}/launch-agent-runtime", "--help"
    system "#{bin}/cleanup-agent-sessions", "--help"
  end
end
