# Scratch copy of the formula in afrossard/homebrew-tap.
class AgentRuntime < Formula
  desc "Launcher and cleanup script for the agent runtime (afrossard/container-base)"
  homepage "https://github.com/afrossard/container-base"
  url "https://github.com/afrossard/container-base/releases/download/5.1.1/container-base-5.1.1.tar.gz"
  sha256 "167697e1768355b6a5467015517d62a650cddbd8dc6b38b492a7e7c7404d178d"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/afrossard/scratch"
    rebuild 1
    manifest_sha256 "4f403679daec0353ba32880c1a0fff3c48e491dcf80dd76a0d14cf5a7f7ca727"
    sha256 cellar: :any_skip_relocation, all: "45ad14ed4025d40957abf28911fa2cf6e5d05dd820af6dfcdb05115231ad8245"
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
