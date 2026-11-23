# Scratch copy of the formula in afrossard/homebrew-tap, rebuilt on Linux only.
class ActualBudgetTransformer < Formula
  desc "Launcher for the bank statement import CLI (afrossard/actual-budget-transformer)"
  homepage "https://github.com/afrossard/actual-budget-transformer"
  url "https://github.com/afrossard/actual-budget-transformer/archive/refs/tags/0.5.0.tar.gz"
  sha256 "612d0f4a9e4ab1e2e0670556c7a022dd1f9711b5be8e8fdb420fbe4d247719ee"
  license "Unlicense"

  bottle do
    root_url "https://ghcr.io/v2/afrossard/scratch"
    rebuild 1
    manifest_sha256 "e7f9f6247880ec0a03dba1ead9b9a4ee8f684ac5c9a9f565fa2d6759f06594d2"
    sha256 cellar: :any_skip_relocation, all: "3be738b9d26bf4befad634be9a0c5549e6ebfff7736ea36926ee708b59bff21f"
  end

  def install
    bin.install "scripts/abt-import"
  end

  # Not a dependency: msb may already be installed by its own installer, and a
  # second copy from brew would shadow or be shadowed by it.
  def caveats
    <<~EOS
      abt-import runs the CLI's image under msb, which this formula does not install.
      If `msb` is not on your PATH yet, install it with either of:
        brew install superradcompany/tap/microsandbox
        curl -fsSL https://install.microsandbox.dev | sh
    EOS
  end

  test do
    # A stub msb that records its arguments: the real one needs a hypervisor.
    (testpath/"msb").write <<~SH
      #!/bin/sh
      printf '%s\\n' "$@" > "#{testpath}/msb-args"
    SH
    chmod 0755, testpath/"msb"
    ENV.prepend_path "PATH", testpath

    system bin/"abt-import", "--help"
    args = (testpath/"msb-args").read
    assert_match "ghcr.io/afrossard/actual-budget-transformer:#{version}\n", args
    assert_match "--help\n", args
  end
end
