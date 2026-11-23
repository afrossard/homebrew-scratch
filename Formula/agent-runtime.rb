# Scratch copy of the formula in afrossard/homebrew-tap.
class AgentRuntime < Formula
  desc "Launcher and cleanup script for the agent runtime (afrossard/container-base)"
  homepage "https://github.com/afrossard/container-base"
  url "https://github.com/afrossard/container-base/releases/download/5.2.0/container-base-5.2.0.tar.gz"
  sha256 "9ab9392e9f404c098247af7927db304f3ca5db7aae7cddc53353f21bcc312ed4"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/afrossard/scratch"
    manifest_sha256 "a01ddeb2a94323150f4c3730d49ca6de015f4c03927b9d87e2186077be208ed4"
    sha256 cellar: :any_skip_relocation, all: "b0bf0586d675c70497044a04267a4d69d89bc2eac95bf8c33ed57bde1b5bfbb6"
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
